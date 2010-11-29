/**
 * Analyzer that consists of
 * - whitespace analysis
 * - lowercasing
 * - accent squashing
 */

package org.workflow4people.lucene.analysis;

import java.io.IOException;
import java.io.Reader;
import org.apache.log4j.Logger;

import org.apache.lucene.analysis.*;

public class WfpAnalyzer extends org.apache.lucene.analysis.Analyzer {
	private static final Logger log = Logger.getLogger(WfpAnalyzer.class);

	public TokenStream tokenStream(String fieldName, Reader reader) { 
		log.debug ("WFP analyzer for field: " + fieldName);
		TokenStream result = new WhitespaceTokenizer(reader);
		
		result = new LowerCaseFilter(result);
		result = new ISOLatin1AccentFilter(result); 
		
		return result; 
	}	
	
	 
	public TokenStream reusableTokenStream(String fieldName, Reader reader) throws IOException {
		      return tokenStream(fieldName, reader);
    }

	
	
	
}
