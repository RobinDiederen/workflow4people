package org.workflow4people

class IndexExpressionDelegate {

	def doc
	
	def IndexExpressionDelegate() {
	}
	
	def run(String scriptText) {
		def s="{ ->\n"+scriptText+"\n}"
		def closure=new GroovyShell().evaluate(s)
		closure.setResolveStrategy(Closure.DELEGATE_FIRST)
		closure.setDelegate(this)
		closure.call()
	}
}
