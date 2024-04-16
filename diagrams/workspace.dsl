workspace {

    model {
        user = person "My favourite User"
        softwareSystem = softwareSystem "Software System"

        user -> softwareSystem "Uses"
    }

    views {
        systemContext softwareSystem "Diagram_the_Best" {
            include *
        }
    }

    configuration {
        scope softwaresystem
    }

}
