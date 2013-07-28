package org.workflow4people.services

class VersionService {

    static transactional = false

	def nextVersionPart(String versionPart) {
		def matcher = versionPart =~ "[0-9]+"
		def newVersionPart
		if (matcher) {
			def newPart= "${new Integer(matcher[0])+1}"
			newVersionPart=matcher.replaceFirst(newPart)
		} else {
			newVersionPart=versionPart+".1"
		}
		return newVersionPart
	}

	def nextVersion(String version) {
		if (version?.contains('.')) {
			def versionParts=version.split("\\.").collect { it }
			def lastPart=versionParts.pop()		
			//	 	versionParts.pop()
			versionParts.push(nextVersion(lastPart))		
			return versionParts.join('.')
					
		} else {
			return nextVersionPart(version)
		}
	
	}
}
