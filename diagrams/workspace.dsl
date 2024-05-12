workspace {

    model {
        hadoopUsers = person "Users" "Software Engineers\nData Engineers\nData Scientists" {
            tags "Hadoop Users"                
        }

        hadoopUserServices = person "Software Services" "APIs\nservices\nsentient AI" {
            tags "Hadoop Interacting Services"
                        
        }
 
        hadoop = softwareSystem "Hadoop" "Java Runtime" "Distributed Cluster" {

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
            sendsJobRequestsHadoop_1_0 = hadoopJobClient -> hadoopJobTracker "Sends job requests"
            sendsJobRequestsHadoop_2_0 = hadoopJobClient -> resourceLayer "Sends job requests"
            schedulesMapReduceHadoop_1_0 = hadoopJobTracker -> hadoopTaskTracker "Schedules Map and Reduce Tasks, Sends Code"
            schedulesMapReduceHadoop_2_0_1 = hadoopJobClient -> hadoopResourceManager "Requests MapReduce job execution"
            schedulesMapReduceHadoop_2_0_2 = hadoopNodeManager -> hadoopTaskTracker "Executes task containers"

            queryLocalityHadoop_1_0 = hadoopJobTracker -> hadoopNameNode "Queries data locality for scheduling"
            queryLocalityHadoop_2_0 = hadoopResourceManager -> hadoopNameNode "Queries data locality for scheduling"
            readInputData = hadoopTaskTracker -> hadoopDataNode "Reads input data for MapReduce Operations\n\nWrites Reduce outputs to HDFS"

            
            
            //HDFS Dependencies
            pollsFiles = hadoopNameNode -> hadoopDataNode "Polls to Tracks Files, Server Locality, Replicas"
            dfsClientQueryMaster = hadoopDfsClient -> hadoopNameNode "Queries data locality"
            dfsClientQueryNodes = hadoopDfsClient -> hadoopDataNode "Queries files directly"

            //Resource Dependencies
            queriesResourceUsage = hadoopResourceManager -> hadoopNodeManager "Monitors resource usage/availability\nReceives node heartbeats"
            assignsWorkToResources = hadoopResourceManager -> hadoopNodeManager "Assigns tasks to be executed on the node"
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

                mapreduceMasterNode = deploymentNode "MapReduce Master Node" {
                    containerInstance mapReduceLayer hadoopJobMasterInstance {
                        description "JobClient"
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

                yarnMasterNode -> node1 "Sends Tasks"
                yarnMasterNode -> node2 "Sends Tasks"

                yarnMasterNode -> dataMasterNode "Queries data locality for task scheduling"
                mapReduceMasterNode -> yarnMasterNode "Sends job execution requests"

                dataMasterNode -> node1 "Polls File allocations"
                dataMasterNode -> node2 "Polls File allocations"

                yarnMasterNode -> node1 "Polls CPU and Memory Usage"
                yarnMasterNode -> node2 "Polls CPU and Memory Usage"
            }
        }

        hadoopUsers -> hadoop "Send Data Processing Jobs\n\nReceive Data Processing Results\n\nSend direct data queries\n\nReceive data query results"
        hadoopUserServices -> hadoop 
       
        hadoopUsersTomapReduceLayer = hadoopUsers -> mapReduceLayer "Sends MapReduceJobs"
        hadoopUsersTohadoopJobClient = hadoopUsers -> hadoopJobClient "Sends MapReduceJobs"
        hadoopUsersToDataLayer = hadoopUsers -> DataLayer "Direct HDFS queries"
        hadoopUsersTohadoopDfsClient = hadoopUsers -> hadoopDfsClient "Direct HDFS queries"


        
        mapReduceLayerToDataLayer = mapReduceLayer -> DataLayer "Queries existing data during task execution"
        mapReduceLayerToDataLayer2 = mapReduceLayer -> DataLayer "Writes MapReduce task results"
    }

    


    views {
        systemContext hadoop "ContextDiagram" {
            include *
        }


        container "Hadoop" {
            include *
    
            exclude sendsJobRequestsHadoop_1_0
            exclude schedulesMapReduceHadoop_1_0
            exclude queryLocalityHadoop_1_0

        }

        component mapReduceLayer "MapReduce_1_0_ComponentDiagram" {
            include *
            
            exclude hadoopUsersToDataLayer
            exclude resourceLayer
            exclude sendsJobRequestsHadoop_2_0
            exclude schedulesMapReduceHadoop_2_0_1
            exclude schedulesMapReduceHadoop_2_0_2
            exclude queryLocalityHadoop_2_0

        }

        component mapReduceLayer "MapReduce_2_0_ComponentDiagram" {
            include *

            exclude hadoopUsersToDataLayer
            
            exclude hadoopJobTracker

            exclude sendsJobRequestsHadoop_1_0
            exclude schedulesMapReduceHadoop_1_0
            exclude queryLocalityHadoop_1_0
        }

        component dataLayer "HDFSComponentDiagram" {
            include *
            exclude hadoopUsersTohadoopJobClient
            exclude hadoopUsersTomapReduceLayer
            exclude sendsJobRequestsHadoop_1_0
            exclude schedulesMapReduceHadoop_1_0
            exclude queryLocalityHadoop_1_0
        }

        component resourceLayer "YarnComponentDiagram" {
            include *
            exclude sendsJobRequestsHadoop_1_0
            exclude schedulesMapReduceHadoop_1_0
            exclude queryLocalityHadoop_1_0
        }

        deployment * hadoopCluster {
            include *
            exclude sendsJobRequestsHadoop_2_0
            exclude queryLocalityHadoop_2_0
            exclude schedulesMapReduceHadoop_2_0_1
            exclude schedulesMapReduceHadoop_2_0_2
            exclude sendsJobRequestsHadoop_1_0
            exclude schedulesMapReduceHadoop_1_0
            exclude queryLocalityHadoop_1_0
            exclude readInputData
            exclude pollsFiles
            exclude queriesResourceUsage
        }

        styles {
            element "Hadoop Software System" {
                icon https://upload.wikimedia.org/wikipedia/commons/thumb/c/c4/Hadoop-logo-new.pdf/page1-2500px-Hadoop-logo-new.pdf.jpg
                //width 250
                //height 200
                //color #000000
                fontSize 20
                shape RoundedBox
            }
            element "Hadoop Users" {
                    width 250
                    height 200
                    //color #000000
                    fontSize 12
                    shape person
            }

            element "Hadoop Interacting Services" {
                    width 250
                    height 200
                    //color #000000
                    fontSize 12
                    shape roundedBox
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
