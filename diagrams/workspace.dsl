workspace {

    model {
        hadoopUsers = person "Users" "Software Engineers\nData Engineers\nData Scientists" {
            tags "Hadoop Users"
                        
        }
 
        hadoop = softwareSystem "Hadoop" "" "" {

            tags "Hadoop Software System"

            mapReduceLayer = container "hadoop-mapreduce" "Processing Management" {
                hadoopJobClient = component "Job Client"
                hadoopJobTracker = component "Job Tracker"
                hadoopTaskTracker = component "Task Tracker" 
            }

            dataLayer = container "hadoop-hdfs" "Data Management" {
                hadoopDfsClient = component "DFS Client"
                hadoopNameNode = component "Name Node"
                hadoopDataNode = component "Data Node"
                
            }

            resourceLayer = container "hadoop-yarn" "Resource Management" {
                hadoopResourceManager = component "Resource Manager"
                hadoopNodeManager = component "Node Manager"
            }

            
            //MapReduce Dependencies
            sendsJobRequests = hadoopJobClient -> hadoopJobTracker "Sends job requests"
            schedulesMapReduce = hadoopJobTracker -> hadoopTaskTracker "Schedules Map and Reduce Tasks, Sends Code"
            queryLocality = hadoopJobTracker -> hadoopNameNode "Queries data locality for scheduling"
            queryResource = hadoopJobTracker -> hadoopResourceManager "Queries resource availability for job scheduling"
            readInputData = hadoopTaskTracker -> hadoopDataNode "Reads input data for MapReduce Operations\n\nWrites Reduce outputs to HDFS"
            
            
            //HDFS Dependencies
            pollsFiles = hadoopNameNode -> hadoopDataNode "Polls to Tracks Files, Server Locality, Replicas"
            dfsClientQueryMaster = hadoopDfsClient -> hadoopNameNode "Queries data locality"
            dfsClientQueryNodes = hadoopDfsClient -> hadoopDataNode "Queries files directly"

            //Resource Dependencies
            queriesResourceUsage = hadoopResourceManager -> hadoopNodeManager "Monitors resource usage/availability\nReceives node heartbeats"
        }


        hadoopCluster = deploymentEnvironment "Hadoop Cluster Deployment Diagram" {

            group "Hadoop Cluster" {
                hadoopJobMasterInstance = deploymentGroup "Hadoop Job Master Node"
                hadoopResourceMasterInstance = deploymentGroup "Hadoop Resource Master Node"
                hadoopDataMasterInstance = deploymentGroup "Hadoop Data Master Node"

                yarnMasterNode = deploymentNode "YARN Resource Master Node" {
                    containerInstance resourceLayer hadoopResourceMasterInstance {
                        description "ResourceManager"
                    }
                }

                mapreduceMasterNode = deploymentNode "MapReduce Job Master Node" {
                    containerInstance mapReduceLayer hadoopJobMasterInstance {
                        description "JobTracker"
                    }
                }

                dataMasterNode = deploymentNode "HDFS Master Node" {
                    containerInstance dataLayer hadoopDataMasterInstance {
                        description "NameNode"
                    }
                }

                node1 = deploymentNode "Node 1" {
                    containerInstance mapReduceLayer {
                        description "Task Tracker"
                    }
                    containerInstance dataLayer {
                        description "Data Node"
                    }
                    containerInstance resourceLayer {
                        description "Node Manager"
                    }
                }
                node2 = deploymentNode "Node 2" {
                    containerInstance mapReduceLayer {
                        description "Task Tracker"
                    }
                    containerInstance dataLayer {
                        description "Data Node"
                    }
                    containerInstance resourceLayer {
                        description "Node Manager"
                    }
                }

                mapreduceMasterNode -> node1 "Sends Tasks"
                mapreduceMasterNode -> node2 "Sends Tasks"

                mapReduceMasterNode -> dataMasterNode "Queries data locality for task scheduling"
                mapReduceMasterNode -> yarnMasterNode "Queries node query usage for task scheduling"

                dataMasterNode -> node1 "Polls File allocations"
                dataMasterNode -> node2 "Polls File allocations"

                yarnMasterNode -> node1 "Polls CPU and Memory Usage"
                yarnMasterNode -> node2 "Polls CPU and Memory Usage"
            }
        }
       
        hadoopUsersTomapReduceLayer = hadoopUsers -> mapReduceLayer "Sends MapReduceJobs"
        hadoopUsersTohadoopJobClient = hadoopUsers -> hadoopJobClient "Sends MapReduceJobs"
        hadoopUsersToDataLayer = hadoopUsers -> DataLayer "Direct HDFS queries"
        hadoopUsersTohadoopDfsClient = hadoopUsers -> hadoopDfsClient "Direct HDFS queries"


        
        mapReduceLayerToDataLayer = mapReduceLayer -> DataLayer "Queries existing data"
        mapReduceLayerToDataLayer2 = mapReduceLayer -> DataLayer "Writes MapReduce job results"
    }


    views {
        systemContext hadoop "ContextDiagram" {
            include *
        }


        container "Hadoop" {
            include *
        }

        component mapReduceLayer "MapReduceComponentDiagram" {
            include *
            exclude queryLocality
            exclude hadoopUsersToDataLayer
        }

        component dataLayer "HDFSComponentDiagram" {
            include *
            exclude hadoopUsersTohadoopJobClient
            exclude hadoopUsersTomapReduceLayer
        }

        component resourceLayer "YarnComponentDiagram" {
            include *
        }

        deployment * hadoopCluster {
            include *
            exclude sendsJobRequests
            exclude schedulesMapReduce
            exclude queryLocality
            exclude queryResource 
            exclude readInputData
            exclude pollsFiles
            exclude queriesResourceUsage
        }

        styles {
            element "Hadoop Users" {
                    width 250
                    height 200
                    //color #000000
                    fontSize 12
                    shape person
            }

            element "Element" {
                fontSize 28
            }

            element  "Sends Tasks" {
                fontSize 50
            }
        }

        theme default
    }
    

}
