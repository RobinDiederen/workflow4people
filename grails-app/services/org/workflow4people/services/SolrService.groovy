package org.workflow4people.services

import org.apache.solr.client.solrj.*
import org.apache.solr.client.solrj.impl.CommonsHttpSolrServer
import org.apache.solr.client.solrj.response.QueryResponse
import org.apache.solr.common.SolrDocumentList
import org.apache.solr.common.SolrInputDocument
import org.apache.solr.common.params.ModifiableSolrParams
import org.apache.solr.client.*
import org.workflow4people.*
import groovyx.gpars.*
import org.codehaus.groovy.grails.commons.*
import java.util.concurrent.atomic.*

class SolrService {
	
	def searchableService
	def sessionFactory
	def executorService
	def grailsApplication

	
	
	boolean running = false
	boolean lock=false
	String currentAction="idle"
	String currentMessage=""
	
	

	boolean abortFlag=false
	AtomicInteger currentItem
	public void incCurrentItem() {
		currentItem.incrementAndGet()
	}
	public int theCurrentItem() {
		return currentItem.get();
	}
	
	def currentItemType
	def failed=0
	def theTotal=0
	def ping=0
	def numDocsInSolr=0
	def numDocsInDb=0
	
	String statusMsg = ""
	
	def getProgress() {
			def crnt=currentItem?currentItem.get():0
			return [running:running, total:theTotal, current:crnt, currentItemType:currentItemType,statusMsg:currentMessage,ping:ping,numDocsInDb:numDocsInDb,numDocsInSolr:numDocsInSolr]		
		
	}
	
	void abort() {
		abortFlag=true
		currentMessage="Abort requested"
	}
	
	void updateStats(dc) {
		def res=search(dc,"*:*",[max:1])
		numDocsInSolr=res.numFound
		numDocsInDb=dc.count()	
	}
	
	def getStats(dc) {
		def res=search(dc,"*:*",[max:1])
		numDocsInSolr=res.numFound
		numDocsInDb=dc.count()
		[numDocsInSolr:numDocsInSolr,numDocsInDb:numDocsInDb]
	}

	def search(dc,q,params=[:]) {
		def dcName=new DefaultGrailsDomainClass(dc).shortName
		SolrDocumentList list
		if (!q || q.length()<1) {
			list=[numFound:0,results:[]]
		} else {
			String urlString = grailsApplication.config.solr.url+"/"+dcName
			SolrServer solr = new CommonsHttpSolrServer(urlString);			
			SolrQuery query = new SolrQuery(q);
	
			query.set("start",(params.offset!=null &&params.offset!="null")?params.offset:0)
			query.set("rows",(params.max!=null &&params.max!="null")?params.max:0)
			
			if(params.sort) {
				def  sortOrder=params.order=="asc" ? SolrQuery.ORDER.asc : SolrQuery.ORDER.desc
				query.setSortField(params.sort,sortOrder)
			}
			
			QueryResponse response = solr.query(query);
			list = response.getResults();
		}
		return list
	}
	
	/*
	 * Expands a 'human' search query into a Solr query that will search title, description, isbn and author
	 * Optionally applies a standard filter and boost
	 *  
	 */
	
	def prepareQuery(dc,q,standardFilter=true,standardBoost=true) {
		def dcName=new DefaultGrailsDomainClass(dc).shortName
		if (!q.contains(":")){
			def terms=q.split(" ");
			// TODO check & make useful queries here			
			if (dcName=="Document") {
				q=terms.collect { term ->
					"(documentDescription:${term} or documentType:${term})"
				}.join(" AND ")
			}

			// TODO check & make useful queries here
			if (dcName=="Task") {
				q=terms.collect { term ->
					"(description:${term} or user:${term})"
				}.join(" AND ")
			}
			
		}
		if (standardFilter) {
			// TODO figure out what's right here for documents
			//q="(${q}) AND -standardPrice:0 AND -nurCode:000 AND -bookCode:0"
			//q="(${q}) AND -nurCode:000 AND -bookCode:0"
			//q="${q} coverCode:3^0.5 coverCode:2^0.5 language:dut^0.5 bookCode:21^1"
		}
		if (standardBoost) {
			// TODO this boosts documents that have recently been updated
			q="{!boost b=recip(ms(NOW,lastUpdated),3.16e-11,1,1)}${q}"
		}
		return q
	}
	
	
	def humansearch(dc,q,params,standardFilter=true,standardBoost=true) {
		def dcName=new DefaultGrailsDomainClass(dc).shortName
		def list	
		if (!q || q.length()<1) {
			list=[numFound:0,results:[]]
		} else {
			list= search(dc,prepareQuery(dc,q,standardFilter,standardBoost),params)
		}
		return list		
	}
	
	def filteredsearch(dc,q,params,filter) {
		def dcName=new DefaultGrailsDomainClass(dc).shortName
		def list
		if (!q || q.length()<1) {
			list=[numFound:0,results:[]]
		} else {
			if (filter && filter.length()>0) {
				list= search(dc,"(${q}) AND (${prepareQuery(dc,filter,false,false)})",params)
			} else {
				list= search(dc,q,params)
			}
		}
		return list
	}
	
		
	/**
	* Generates a JSON response to feed the datalist from a Solr query
	* @param dc The domain class to be used
	* @param params The parameters from the http request
	* @param request the HTTPServletRequest
	* @param query the HQL query
	* @param the HQL query that counts the number of items in above query, if null, the query is created by prepending 'select count(*) ' to the query above
	* @param filterColumnName The name of the column to be used for filtering (can be null to disable)
	* @param actions A closure that provides customized actions in the actions column of the table
	* @param queryParams a parameter map for the query
	* @return a map that is ready to be rendered as a JSON message
	*/
	
	
	def jsonsearch(dc,params,request,query,listProperties=null,actions=null,queryParams=[:]) {
		def dcName=new DefaultGrailsDomainClass(dc).shortName
		def title=dc.getName();
		title=title.replaceAll (".*\\.", "")
		def propName=title[0].toLowerCase()+title.substring(1)
		
		
		def columns=listProperties ? listProperties : dc.listProperties
		//def columns= dc.listProperties
		def sortName=columns[new Integer(params.iSortCol_0)]
		sortName=sortName? sortName:columns[0]
		
		def documentList
		
		//Create Id for the table
		def detailTableId="detailTable_"+dc
		detailTableId=detailTableId.replace(".","_")
		detailTableId=detailTableId.replace("class ","")
		
		def res=filteredsearch(dc,query,[max:params.iDisplayLength,offset:params.iDisplayStart,order:params.sSortDir_0,sort:sortName],params.sSearch)
		
		//documentList=res.collect { dc.get(it.id)}
		documentList=res
		
		def iTotalRecords=res.numFound
		def iTotalDisplayRecords=iTotalRecords

		def aaData=[]
			documentList.each { doc ->

				//def inLine=[DT_RowId:doc.id]
				def inLine=[:]
				def i=0
				columns.each {
					inLine +=["${i}":doc."${it}"]
					i++
				}
				

				def baseUrl=request.contextPath

				if(!actions) {
					actions= { dok, env -> """<div class="btn-group"><span class="btn btn-small" onclick="dialog.formDialog('${dok.id}','${propName}',{ refresh : '${detailTableId}'}, null)">edit</span>&nbsp;<span class="btn btn-small" onclick="dialog.deleteDialog(${dok.id},'${propName}',{ refresh : '${detailTableId}'}, null)">&times;</span></div>""" }
				}
				inLine+=["${i}":actions(doc,['detailTableId':detailTableId])]
				aaData+=inLine
			}

			def json = [sEcho:params.sEcho,iTotalRecords:iTotalRecords,iTotalDisplayRecords:iTotalDisplayRecords,aaData:aaData]
		return json
	}
	
	
	/**
	* Generates a JSON response to feed the datalist
	* @param dc The domain class to be used
	* @param params The parameters from the http request
	* @param request the HTTPServletRequest
	* @param filterColumnName The name of the column to be used for filtering (can be null to disable)
	* @param actions A closure that provides customized actions in the actions column of the table
	* @return a map that is ready to be rendered as a JSON message
	*/

	def autocomplete(dc,params,request,labelFieldName="name",descriptionFieldName="description") {
		def dcName=new DefaultGrailsDomainClass(dc).shortName
		def title=dc.getName();
		title=title.replaceAll (".*\\.", "")
		def propName=title[0].toLowerCase()+title.substring(1)
				 
		def maxResults=10
					
		def documentList=humansearch(dc,params.term,[max:maxResults])
		
		//documentList=res.collect { dc.get(it.id)}
		
		def json=[]
		documentList.each { doc ->
			def label=doc."${labelFieldName}"
			def description=doc."${descriptionFieldName}"
			json+=[value:doc.isbn,label:"${label}", description:"${doc.description}"]				
		}
		return json
	}

	
	def getNewestItemInIndex(dc) {
		def dcName=new DefaultGrailsDomainClass(dc).shortName
		SolrDocumentList list
		String urlString = grailsApplication.config.solr.url+"/"+dcName
		SolrServer solr = new CommonsHttpSolrServer(urlString);
		SolrQuery query = new SolrQuery("*:*");			
		query.set("sort","lastUpdated desc")
		query.set("rows","1")
		QueryResponse response = solr.query(query);
		list = response.getResults();
		if (list.size()!=1) {
			return null
		} else {
			return list[0]
		}
	}
	
	/*
	 * Date-based indexing. This one has the great advantage it does not need to write to the database
	 */
	
	void reIndexByLastUpdated(dc) {
		def defaultDomainClass = new DefaultGrailsDomainClass( dc )
		def dcName=defaultDomainClass.shortName
		currentItemType=dcName
		log.trace "Reindex by last updated for ${dcName}"
		ping++
		if (!running && !lock) {		
			lock=true
			running=true
			abortFlag=false
			String urlString = grailsApplication.config.solr.url+"/"+dcName
			SolrServer solr = new CommonsHttpSolrServer(urlString);
			def startDate
			def newestItemInIndex=getNewestItemInIndex(dc)
	
			if (newestItemInIndex) {
				startDate=newestItemInIndex["lastUpdated"]
			} else {
				startDate=new Date(0)
			}		
			
			// Put the end date 1 second earlier than current time; this should create a 'clean cut'
			Date endDate= new Date()
			endDate.setTime(endDate.getTime()-1000);
			
			log.trace  "Indexing items from ${startDate} to ${endDate} (if any)"
			theTotal =dc.executeQuery("""select count(*) from ${dcName} d where (d.lastUpdated>:startDate and d.lastUpdated<:endDate)""",[startDate:startDate,endDate:endDate])[0]
			currentItem=new AtomicInteger(0)
			def session = sessionFactory.getCurrentSession()
			def items
			//def offset=0
			Long currentId=0
			while ((items = dc.findAll("from ${dcName} d where d.lastUpdated>:startDate and d.lastUpdated<:endDate and d.id>:currentId order by d.id asc",[startDate:startDate,endDate:endDate,currentId:currentId],[max:500])) && !abortFlag) {
				try {
					currentId=items[items.size()-1].id
					log.trace "Reindexing ${items.size()} items from ${items[0].id}"
					currentMessage="Reindexing ${items.size()} items from ${items[0].id}"
					updateStats(dc)
					/*
					GParsPool.withPool { pool ->
						
						items.eachParallel { item ->
							try {
								def sid=item.getSolrInputDocument();
								solr.add(sid)
							} catch (Exception e) {
								log.error "Caught exception while indexing ${item}: ${e.message}"
							}

							incCurrentItem()
						}
	
					}
					*/
					// Non-concurrent version

					items.each { item ->
						try {
							log.trace item
							if ( !defaultDomainClass.hasProperty("deleted") || !item.deleted) {
									def sid=item.getSolrInputDocument();
									solr.add(sid)
								} else {
									solr.deleteById(item.id.toString())								
								}
						} catch (Exception e) {
							log.error "Caught exception while indexing ${item}: ${e.message}"
						}

						incCurrentItem()
					}

					
					solr.commit()
			
					session.flush()
					session.clear()
				} catch (Exception e) {
					log.error "Caught exception while indexing: ${e.message}"
					sleep(60000)
				}
				currentMessage+=' completed.'
				
				log.debug "Finished indexing ${items.size()} items from ${items[0].id}"
			}
			log.trace "Finished indexing"
			running=false
			lock=false
		}
	}
	
	/*
	 * This method reindexes all items from a certain isbn onwards
	 * It keeps the last isbn it indexed as the starting point for the next cycle, so the query uses the isbn index to find the next chunk (which is quick)
	 */
	
	
	 void reIndexAll(dc,fromId) {
		def defaultDomainClass = new DefaultGrailsDomainClass( dc )
		def dcName=defaultDomainClass.shortName
		abortFlag=false
		Long currentId=fromId
		def chunkSize=50
		try {
			if (!running && !lock) {
			
				lock=true
				running=true				
				String urlString = grailsApplication.config.solr.url+"/"+dcName
				//SolrServer solr = new CommonsHttpSolrServer(urlString);
				int maxbuf=500
				int maxthreads=1
				SolrServer solr = new org.apache.solr.client.solrj.impl.StreamingUpdateSolrServer(urlString,maxbuf,maxthreads)
				log.trace "currentId=${currentId}"
				theTotal =dc.executeQuery("""select count(*) from ${dcName} d where (d.id>:currentId)""",[currentId:currentId])[0]
				log.trace "theTotal=${theTotal}"
				currentItem=new AtomicInteger(0)				
				def session = sessionFactory.getCurrentSession()
				def items

				while ((items = dc.findAll("from ${dcName} d where d.id>:currentId order by d.id asc",[currentId:currentId],[max:chunkSize])) && !abortFlag) {
					currentId=items[items.size()-1].id					
					
					try {
						
						def startTime=new Date().time
						log.trace "Reindexing ${items.size()} items from ${items[0].id} through ${items[items.size()-1].id}"
						currentMessage="Reindexing ${items.size()} items from ${items[0].id} through ${items[items.size()-1].id}"
						updateStats(dc)
	
						/*GParsPool.withPool { pool ->
							
							items.eachParallel { item ->
								incCurrentItem()
								def sid=item.getSolrInputDocument();
								solr.add(sid)								
							}

						}
						*/
						// Non-concurrent version	
							items.each { item ->
								log.trace item
								incCurrentItem()
								
								if ( !defaultDomainClass.hasProperty("deleted") || !item.deleted) {
									def sid=item.getSolrInputDocument();
									solr.add(sid)
								} else {
									solr.deleteById(item.id.toString())								
								}
							}
						
						log.trace "committing"
						solr.commit()
						
						
						session.flush()
						session.clear()
						def endTime=new Date().time
						log.trace "Reindexed ${items.size()} items in ${(endTime-startTime)/1000} seconds"
						currentMessage="Reindexed ${items.size()} items in ${(endTime-startTime)/1000} seconds"												
						
						
					} catch (Exception e) {
						log.error "Caught exception while indexing (inner loop): ${e.getMessage()}"
						currentMessage="Caught exception while indexing (inner loop): ${e.getMessage()}"
						sleep(10000)
					}
					
				}
				running=false
				lock=false
			} else {
				log.trace "Skipped reindex because of locks running=${running} lock=${lock}"
			}		 
		} catch (Exception e) {
			log.error "Caught exception while indexing: ${e.message}"
			currentMessage="Caught exception while indexing: ${e.message}"
			running=false
			lock=false
		}
		log.trace "Completed indexing"
		currentMessage="Completed indexing"
	}
	
	def deleteItem(dc,id) {
		def dcName=new DefaultGrailsDomainClass(dc).shortName
		log.trace "Deleting ${id} from Solr"
		String urlString = grailsApplication.config.solr.url+"/"+dcName
		SolrServer solr = new CommonsHttpSolrServer(urlString);
		solr.deleteById(id.toString())
		solr.commit()
		
		log.trace "Completed deleting ${id} from Solr"		

	}
	
}
