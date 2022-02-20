folder('demo')
folder('demo/DSL')

pipelineJob("demo/DSL/JOB1") {
	definition {
		cpsScm {
			scm {
				git {
					remote {
						url("https://github.com/mohandevops78/mvn-project.git")
					}
					branch("*/main")
				}
			}
			scriptPath("Jenkinsfile")
			lightweight(lightweight = true)
		}
	}
}

pipelineJob("demo/DSL/JOB2") {
	definition {
		cpsScm {
			scm {
				git {
					remote {
						url("https://github.com/mohandevops78/mvn-project.git")
					}
					branch("*/main")
				}
			}
			scriptPath("Jenkinsfile")
			lightweight(lightweight = true)
		}
	}
}   
