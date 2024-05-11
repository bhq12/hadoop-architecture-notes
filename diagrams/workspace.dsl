workspace {

    model {
        hadoopUsers = person "Users" "Software Engineers\nData Engineers\nData Scientists" {
            tags "Hadoop Users"
                        
        }
 
        hadoop = softwareSystem "Hadoop" "" "" {

            //TODO: Are these the containers?
            tags "Hadoop Software System"

            mapReduceLayer = container "hadoop-mapreduce" "Java" {
                hadoopJobTracker = component "Job Tracker"
                hadoopTaskTracker = component "Task Tracker" 
            }

            dataLayer = container "hadoop-hdfs" "Java" {
                hadoopDataNode = component "Data Node"
                hadoopNameNode = component "Name Node"
            }

            //hadoopJobTracker -> hadoopTaskTracker "Schedules Map and Reduce Tasks, Sends Code"
            //hadoopJobTracker -> hadoopNameNode "Queries data locality for scheduling"
            //hadoopTaskTracker -> hadoopDataNode "Writes Reduce outputs to HDFS"
            //hadoopNameNode -> hadoopDataNode "Polls to Tracks Files, Server Locality, Replicas"
                        
        }


        hadoopCluster = deploymentEnvironment "Hadoop Cluster Deployment Diagram" {

            group "Hadoop Cluster" {
                hadoopMasterInstance = deploymentGroup "Hadoop Master Node"
                hadoopInstance1 = deploymentGroup "Hadoop Node 1"
                hadoopInstance2 = deploymentGroup "Hadoop Node 2"
                hadoopInstance3 = deploymentGroup "Hadoop Node 3"

                masterNode = deploymentNode "Master Node" {
                    containerInstance mapReduceLayer hadoopMasterInstance
                    containerInstance dataLayer hadoopMasterInstance
                }

                node1 = deploymentNode "Node 1" {
                    containerInstance mapReduceLayer hadoopInstance1
                    containerInstance dataLayer hadoopInstance1
                }
                node2 = deploymentNode "Node 2" {
                    containerInstance mapReduceLayer hadoopInstance2
                    containerInstance dataLayer hadoopInstance2
                }

                node3 = deploymentNode "Node 3" {
                    containerInstance mapReduceLayer hadoopInstance3
                    containerInstance dataLayer hadoopInstance3
                }

                masterNode -> node1 "Sends Tasks"
                masterNode -> node2 "Sends Tasks"
                masterNode -> node3 "Sends Tasks"
            }
        }

       

       
        hadoopUsers -> mapReduceLayer "Sends MapReduceJobs"
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

        deployment * hadoopCluster {
            include *

            animation {
                hadoopMasterInstance
                hadoopInstance1
                hadoopInstance2
                hadoopInstance3
            }
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
