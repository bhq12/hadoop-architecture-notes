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
                hadoopDataNode = component "Data Node"
                hadoopNameNode = component "Name Node"
            }

            resourceLayer = container "hadoop-yarn" "Resource Management" {
                hadoopResourceManager = component "Resource Manager"
                hadoopNodeManager = component "Node Manager"
            }

            sendsJobRequests = hadoopJobClient -> hadoopJobTracker "Sends job requests"
            schedulesMapReduce = hadoopJobTracker -> hadoopTaskTracker "Schedules Map and Reduce Tasks, Sends Code"
            queryLocality = hadoopJobTracker -> hadoopNameNode "Queries data locality for scheduling"
            queryResource = hadoopJobTracker -> hadoopResourceManager "Queries resource availability for scheduling"
            readInputData = hadoopTaskTracker -> hadoopDataNode "Reads input data for MapReduce Operations\n\nWrites Reduce outputs to HDFS"
            pollsFiles = hadoopNameNode -> hadoopDataNode "Polls to Tracks Files, Server Locality, Replicas"

            queriesResourceUsage = hadoopResourceManager -> hadoopNodeManager "Queries resource usage/availability\nMonitors node heartbeats"
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
       
        hadoopUsers -> mapReduceLayer "Sends MapReduceJobs"
        hadoopUsers -> hadoopJobClient "Sends MapReduceJobs"
        hadoopUsers -> DataLayer "Direct HDFS queries"
        mapReduceLayer -> DataLayer "Queries existing data"
        mapReduceLayer -> DataLayer "Writes MapReduce job results"
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
        }

        component dataLayer "HDFSComponentDiagram" {
            include *
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
        }
    }
    

}
