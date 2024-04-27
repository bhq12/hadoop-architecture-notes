workspace {

    model {
        user = person "My favourite User"

        hadoop = softwareSystem "Hadoop" "" "" {
            tags "Hadoop Software System"
                        
        }

        competitors = softwareSystem "Competitors" "Spark\nSnowflake\nDatabricks" ""  {
                tags "Hadoop Competitors"
        }

        operatingSystems = softwareSystem "OperatingSystems" "Recommended: Linux\n\nSupported but not recommended: Windows\n\nUnsupported: macOS" ""  {
                tags "Operating Systems"
        }

        projectManagementSystems = softwareSystem "ProjectManagementSystems" "Issue Tracking: Jira\nChange Tracking: Mailing List\nSource Control: Github" "" {
                tags "Project Management Systems"
        }
        

        hadoop -> competitors "Competes With"
        hadoop -> operatingSystems "Runs On"
        hadoop -> projectManagementSystems "Tracked With"
    }


    views {
        systemContext hadoop "ContextDiagram" {
            include *
        }
        

        #themes https://github.com/bhq12/bhq12-structurizr-themes-repository/blob/main/hadoop-theme/theme.json
        #themes https://static.structurizr.com/themes/amazon-web-services-2020.04.30/theme.json

        styles {
            element "Hadoop Software System" {
                icon https://upload.wikimedia.org/wikipedia/commons/thumb/c/c4/Hadoop-logo-new.pdf/page1-2500px-Hadoop-logo-new.pdf.jpg
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

    configuration {
        scope softwaresystem
    }

}
