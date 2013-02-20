package org.workflow4people

class OfficeDocConfigDelegate {
	
	def document
	def xml
	def config
	
	
	def OfficeDocConfigDelegate(def documentInstance, slurpedXml) {
		xml = slurpedXml
		document = documentInstance
		
		// Slurp config
		if (document?.documentType?.cmisDocumentScript) {
			def cfg = document.documentType.cmisDocumentScript
			config  = new ConfigSlurper().parse(cfg)
		}	
	}
	
	/*
	 * Process the closure using the current object as the delegate
	 * @param closure the closure to be processed
	 */
	def process(closure) {
		try {
			closure.setResolveStrategy(Closure.DELEGATE_FIRST)
			closure.setDelegate(this)
			closure.call()
		} catch (Exception e) {
			//log.error "OfficeDocConfig execute closure failed"
		}
	}
	
	/*
	 * Create current date (String)
	 */
	String getCurDateAsString(formatString="d-M-yyyy") {
		GregorianCalendar date = new GregorianCalendar();
		date.setTimeInMillis(System.currentTimeMillis());
		return date.format(formatString);
	}
	
	// Template to use for document generation
	def getProcessedTemplateFilePath() {
		if (config?.document?.template) {
			def value = config.document.template
			if (value instanceof Closure) {
				return process(value)
			} else {
				return value
			}
		} else {
			return null
		}
	}
	
	// Template result filename
	def getProcessedDocumentFileName() {
		if (config?.document?.name) {
			def value = config.document.name
			if (value instanceof Closure) {
				return process(value)
			} else {
				return value
			}
		} else {
			return null
		}
	}
	
	// Template result filename path (only the path)
	def getProcessedDocumentFilePath() {
		if (config?.document?.path) {
			def value = config.document.path
			if (value instanceof Closure) {
				return process(value)
			} else {
				return value
			}
		} else {
			return document.cmisPath
		}
	}
	
	// Fields for use in template
	def getProcessedDocumentFields() {
		if (config?.document?.fields) {
			def fieldMap = config.document.fields
			def resultMap = [:]
			fieldMap.each{ key, value ->
				if (null != value) {
					def res = ""
					if (value instanceof Closure) {
						res = process(value)
					} else {
						res = value
					}
					String stringValue = res.toString()
					resultMap[key] = stringValue
				}
			}
			return resultMap
		} else {
			return null
		}
	}
	
}
