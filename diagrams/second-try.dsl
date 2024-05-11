workspace {

    model {
        hadoopUsers = person "Users" "Enterprise Customers\nSoftware Engineers\nData Engineers\nData Scientists" {
            tags "Hadoop Users"
                        
        }

        hadoopDevelopers = person "Developers" "Apache Community Developers\nEnterprises\nVolunteers" {
            tags "Hadoop Developers"
                        
        }

        hadoopInspiration = softwareSystem "MapReduce" "Simplified Data Processing on Large Clusters\nGoogle\n2004" {
            tags "MapReduce Paper"
                        
        }

        hadoopLanguage = softwareSystem "Java" "Object Oriented Programming Language" {
            tags "Hadoop Language"
                        
        }

        competitors = softwareSystem "Competitors" "Spark\nSnowflake\nDatabricks" ""  {
                tags "Hadoop Competitors"
        }

        operatingSystems = softwareSystem "Operating Systems" "Recommended: Linux\n\nSupported but not recommended: Windows\n\nUnsupported: macOS" ""  {
                tags "Operating Systems"
        }

        projectManagementSystems = softwareSystem "Project Management Systems" "Issue Tracking: Jira\nChange Tracking: Mailing List\nSource Control: Github" "" {
                tags "Project Management Systems"
        }

        hadoop = softwareSystem "Hadoop" "" "" {

            //TODO: Are these the containers?
            tags "Hadoop Software System"

            mapReduceLayer = group "Map Reduce Project (MapReduce Layer)" {
                hadoopJobTracker = container "Job Tracker"
                hadoopTaskTracker = container "Task Tracker" 
            }

            dataLayer = group "Hadoop HDFS Project (Data Layer)" {
                hadoopDataNode = container "Data Node"
                hadoopNameNode = container "Name Node"
            }

            hadoopJobTracker -> hadoopTaskTracker "Schedules Map and Reduce Tasks, Sends Code"
            hadoopJobTracker -> hadoopNameNode "Queries data locality for scheduling"
            hadoopTaskTracker -> hadoopDataNode "Writes Reduce outputs to HDFS"
            hadoopNameNode -> hadoopDataNode "Polls to Tracks Files, Server Locality, Replicas"
                        
        }




       


        

        hadoop -> competitors "Competes With"
        hadoop -> operatingSystems "Runs On"
        hadoop -> projectManagementSystems "Tracked With"
        hadoop -> hadoopUsers "Used By"
        hadoop -> hadoopInspiration "Inspired By"
        hadoop -> hadoopDevelopers "Developed By"
        hadoop -> hadoopLanguage "Written In"

    }


    views {
        systemContext hadoop "ContextDiagram" {
            include *
        }


        container "Hadoop" {
            include *
        }
        
        styles {
            element "Hadoop Software System" {
                icon https://upload.wikimedia.org/wikipedia/commons/thumb/c/c4/Hadoop-logo-new.pdf/page1-2500px-Hadoop-logo-new.pdf.jpg
                width 250
                height 200
                color #000000
                fontSize 12
                shape RoundedBox
            }
            element "Hadoop Users" {
                icon https://raw.githubusercontent.com/bhq12/bhq12-structurizr-themes-repository/main/hadoop-theme/hadoop-users.png
                width 250
                height 200
                color #000000
                fontSize 12
                shape person
            }
            element "MapReduce Paper" {
                icon https://raw.githubusercontent.com/bhq12/bhq12-structurizr-themes-repository/main/hadoop-theme/hadoop-inspiration.png
                width 250
                height 200
                color #000000
                fontSize 12
                shape RoundedBox
            }
            element "Hadoop Developers" {
                icon https://raw.githubusercontent.com/bhq12/bhq12-structurizr-themes-repository/main/hadoop-theme/hadoop-founders.png
                width 250
                height 200
                color #000000
                fontSize 12
                shape RoundedBox
            }
            element "Hadoop Language" {
                icon https://raw.githubusercontent.com/bhq12/bhq12-structurizr-themes-repository/main/hadoop-theme/hadoop-language.png
                width 250
                height 200
                color #000000
                fontSize 12
                shape RoundedBox
            }
            element "Hadoop Competitors" {
                icon https://raw.githubusercontent.com/bhq12/bhq12-structurizr-themes-repository/main/hadoop-theme/hadoop-competitors-2.png
                width 250
                height 200
                color #000000
                fontSize 12
                shape RoundedBox
            }
            element "Operating Systems" {
                icon https://raw.githubusercontent.com/bhq12/bhq12-structurizr-themes-repository/main/hadoop-theme/hadoop-operating-systems.png
                width 250
                height 200
                color #000000
                fontSize 12
                shape RoundedBox
            }
            element "Project Management Systems" {
                icon https://raw.githubusercontent.com/bhq12/bhq12-structurizr-themes-repository/main/hadoop-theme/hadoop-project-management-systems.png
                width 250
                height 200
                color #000000
                fontSize 12
                shape RoundedBox
            }
        }
    }

    //configuration {
        //scope softwaresystem
    //}

}
