workspace {

    model {
        user = person "My favourite User"
        hadoop = softwareSystem "Hadoop" {

            hadoopAssemblies = container "hadoop-assemblies"
            hadoopBuildTools = container "hadoop-build-tools"
            hadoopClientModules = container "hadoop-client-modules"
            hadoopCloudStorageProject = container "hadoop-cloud-storage-project"
            hadoopCommonProject = container "hadoop-common-project"
            hadoopDist = container "hadoop-dist"
            hadoopHdfsProject = container "hadoop-hdfs-project"
            hadoopMapReduceProject = container "hadoop-mapreduce-project"
            hadoopMavenPlugins = container "hadoop-maven-plugins"
            hadoopMiniCluster = container "hadoop-minicluster"
            hadoopProject = container "hadoop-project"
            hadoopProjectDist = container "hadoop-project-dist"
            hadoopTools = container "hadoop-tools"
            hadoopYarnProject = container "hadoop-yarn-project"
            //NOTE: Unsure if these connections are true
            hadoopMiniCluster -> hadoopMapReduceProject "Runs map reduce operations"
            
            hadoopProject -> hadoophadoopMapReduceProject "Sends MapReduce Requests"
            hadoopProject -> hadoophadoopMapReduceProject "Returns MapReduce Responses"

            
        }

        user -> hadoop "Uses"
    }


    views {
        systemContext hadoop "ContextDiagram" {
            include *
        }
        
        container hadoop "ContainerDiagram" {
            include *
            autoLayout lr
        }
    }

    configuration {
        scope softwaresystem
    }

}
