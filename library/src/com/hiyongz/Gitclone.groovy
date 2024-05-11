package org.foo;
def checkOutFrom(branch,repo) {
  git branch: "$branch", credentialsId: 'TECHSUN-TFS-JENKINS', url: "https://tfs2015.techsun.com/tfs/DefaultCollection/Devops%20Teams/_git/$repo"
}
