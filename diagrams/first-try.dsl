workspace {

    model {
        user = person "My favourite User"
        hadoop = softwareSystem "Hadoop" {
            # THIS FILE IS VERY HELPFUL /Users/brookqueree/Documents/repos/hadoop/BUILDING.txt (line 120-ish onwards
            hadoopAssemblies = container "hadoop-assemblies"
            
            #  (Build tools like checkstyle, etc.)
            hadoopBuildTools = container "hadoop-build-tools"

            # (Hadoop client modules)
            hadoopClientModules = container "hadoop-client-modules"

            # (Generates artifacts to access cloud storage like aws, azure, etc.)
            hadoopCloudStorageProject = container "hadoop-cloud-storage-project"

            # (Hadoop Common)
            hadoopCommonProject = container "hadoop-common-project"

            # (Hadoop distribution assembler)
            hadoopDist = container "hadoop-dist"             

            # RANDOM : hadoop-project-dist (Parent POM for modules that generate distributions.)
            
            #  (Hadoop HDFS)
            hadoopHdfsProject = container "hadoop-hdfs-project"

            # (Hadoop MapReduce)
            hadoopMapReduceProject = container "hadoop-mapreduce-project" "Hadoop Mapreduce Project" "Test" {
                tags "Hadoop - MapReduce Project"
            }

            # (Maven plugins used in project)
            hadoopMavenPlugins = container "hadoop-maven-plugins"             

            # (Hadoop minicluster artifacts)
            hadoopMiniCluster = container "hadoop-minicluster"             

            # (Parent POM for all Hadoop Maven modules.(All plugins & dependencies versions are defined here.)
            hadoopProject = container "hadoop-project"             


            hadoopProjectDist = container "hadoop-project-dist"
            
            # (Hadoop tools like Streaming, Distcp, etc.) hadoopYarnProject = container "hadoop-yarn-project" # (Hadoop YARN) COMPONENTS:
            hadoopTools = container "hadoop-tools"             

            # hadoop-common-project components:
            # 
            # hadoop-annotations     -  (Generates the Hadoop doclet used to generate the Javadocs)
            # hadoop-auth
            # hadoop-auth-examples
            # hadoop-common
            # hadoop-kms
            # hadoop-minikdc
            # hadoop-nfs
            # hadoop-registry


            //NOTE: Unsure if these connections are true
            hadoopMiniCluster -> hadoopMapReduceProject "Runs map reduce operations"
            
            hadoopProject -> hadoopMapReduceProject "Sends MapReduce Requests"
            hadoopProject -> hadoopMapReduceProject "Returns MapReduce Responses"

            
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

        #themes https://github.com/bhq12/bhq12-structurizr-themes-repository/blob/main/hadoop-theme/theme.json
        #themes https://static.structurizr.com/themes/amazon-web-services-2020.04.30/theme.json

        styles {
            element "Hadoop - MapReduce Project" {
                icon https://miro.medium.com/v2/resize:fit:1400/1*1gx5I6RbBoJieKjT-mzRzA.png
                color #ffffff
                fontSize 22
                shape Person
            }
        }
    }

    configuration {
        scope softwaresystem
    }

}
