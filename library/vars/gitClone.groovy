def call(Map params = [:]) {  
    def defaults = [  
        url: '',  
        credentialsId: '',  
        branch: 'master',  
        dir: '.',  
    ]  
  
    params = params.getOrDefault(defaults, params)  
  
    if (params.url.trim().isEmpty()) {  
        error('git url must be specified')  
    }  
    if (params.credentialsId.trim().isEmpty()) {  
        error('credentialsId must be specified')  
    }  
    checkout([  
        $class: 'GitSCM',  
        branches: [[name: "${params.branch}"]],  
        doGenerateSubmoduleConfigurations: false,  
        extensions: [],  
        submoduleCfg: [],  
        userRemoteConfigs: [[  
            credentialsId: params.credentialsId,  
            url: params.url  
        ]]  
    ])  
    return params.dir  
}
