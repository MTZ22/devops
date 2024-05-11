def gitClone(git_branch,git_url){
    git branch: "${git_branch}", credentialsId: 'TECHSUN-TFS-JENKINS', url: '${git_url}'
}