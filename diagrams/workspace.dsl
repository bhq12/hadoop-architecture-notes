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
        

        hadoop -> competitors "Competes With"
        hadoop -> operatingSystems "Runs On"
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
        }
    }

    configuration {
        scope softwaresystem
    }

}
