# Example_Shiny_Table_Icons

## Introduction
This is an example of how to combine a [Reactable](https://glin.github.io/reactable/) table, [Tippy](https://tippy.john-coene.com/) tooltips, and [Font Awesome](https://fontawesome.com/) icons together. The motivation for this reproducible example is to show help icons after tooltips in the column headers for a Shiny Reactable table. This example Github repository was motivated by my colleagues question on [StackOverflow](https://stackoverflow.com/questions/73657375/how-to-add-an-icon-in-front-of-specific-column-name-of-reactable).

## Walkthrough

The process to add the icons to the table is straight forward once the table is setup. In this example, I use the gas mileage data and use this inside a Reactable like so:

``` 
output$tablePlot <- renderReactable({
  # generate bins based on input$bins from ui.R
    output_data <- as_tibble(mtcars[1:6, ], rownames = "car") %>%
                    select(car:hp)
      
    reactable(
      data,
        columns = list(
          mpg = colDef(header = with_tooltip("mpg", "Miles per US gallon")),
          cyl = colDef(header = with_tooltip("cyl", "Number of cylinders"))
        )
   )
 })
 ```
 
This will generate a simple Reactable table based on several columns specified in the StackOverflow question This is placed in the server.R or server() function of the Shiny app. Then, the client side render call if made in either ui.R or ui() like so:

```
ui <- fluidPage(
    ...,
    # Application title
    titlePanel("Shiny Help Table Icon - Gas Mileage Example"),


    # Show a plot of the generated distribution
    mainPanel(
         reactableOutput("tablePlot")
    )
    
)
```

In order to add the icon component to the reactable Table outputted, we can utilise Font Awesome and CSS. In order for you to be able to do this you need to have a Font Awesome Access Kit. This requires you to create a Font Awesome account [here](https://fontawesome.com/start) and create an access kit. Once you have created an access kit, you can use this in your Shiny app. Once you have done this, including the Font Awesome library and the CSS for the column names containing tippy tooltips is straight forward:

```
ui <- fluidPage(

  
    # IMPORTANT NOTE: you need to have access to a font awesome access kit. Create one via fontawesome.com in your
    # account settings and copy the link that it gives you in the kitname. It will look something like:
    # <script src="https://kit.fontawesome.com/9999a9a999.js" crossorigin="anonymous"></script> - this link is just 
    # an example of the format.
    
  # This adds the script tag to the head of the Shiny document. It injects Font Awesome into the Shiny app.
    tags$head(HTML('<script src="https://kit.fontawesome.com/*kitname*.js" crossorigin="anonymous"></script>')),
    
    # Append a style tag to the .tippy class. The tippy package adds tooltips to the columns. This appends a style to
    # those tooltips.
    tags$style(HTML('.tippy:after {
         font-family: "Font Awesome 5 Free";     
         content: "\\f059";
    }')),
    
    # Application title
    titlePanel("Shiny Help Table Icon - Gas Mileage Example"),


    # Show a plot of the generated distribution
    mainPanel(
         reactableOutput("tablePlot")
    )
    
)
```
The code: `tags$head(HTML('<script src="https://kit.fontawesome.com/*kitname*.js" crossorigin="anonymous"></script>'))` uses htmltools to add the script tag to the head. This gives your Shiny app access to get the Font Awesome library. You need to change *kitname* with the identifier you were given when you created your Font Awesome account.

The code: 

```
    tags$style(HTML('.tippy:after {
         font-family: "Font Awesome 5 Free";     
         content: "\\f059";
    }'))
```

adds a css style to the tippy class. The `.tippy` class is used for any column that has a tooltip. I use the pseudo class `:after` to tell the Shiny webpage to run the CSS instructions after the `.tippy` class. Then after this I specify the `font-family` as Font Awesome 5 Free, which is the font family you use when accessing the icons via CSS. The line `content: "\\f059";` instructs the webpage to add the circle question icon from Font Awesome. The HEX code \f059 adds [Circle question](https://fontawesome.com/icons/circle-question?s=solid&f=classic) as the icon. Note: I put \\f059 because R by default interprets the \. Therefore to escape the \ we need to add \\f059, which means that \f059 will be passed through to the CSS.

This will produce the question mark after the column name as required. 

You can also choose to add the CSS into an external style sheet and load that. I have done it inline for the sake of keeping the example contained in one file. 
