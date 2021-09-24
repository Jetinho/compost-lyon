# BASIC INSTRUCTIONS FOR PROJECT PARTICIPATION AND DEVELOPMENT :

Data to be completed with information worth sharing with people participating to the project.

## Deploy :

- Production :

`git push heroku main`

`heroku run rake db:migrate`
(if need to run migrations)

- Staging : 

`git push staging staging:main`

`heroku run rake db:migrate`
(if need to run migrations)

## Run tests locally : 
`bundle exec rspec`

Edit credentials :
`EDITOR=vim rails credentials:edit`

## Data source used for retrieving data

[Data Grand Lyon - sites de compostage (JSON)](https://download.data.grandlyon.com/ws/grandlyon/gip_proprete.gipcomposteur_latest/all.json?maxfeatures=-1&start=1)

## Update sitemap manually after adding resources

`heroku run rake sitemap:refresh --app compost-lyon`

## Useful resources :

- [Heroku for rails apps - Getting Started on Heroku with Rails 5.x](https://devcenter.heroku.com/articles/getting-started-with-rails5)

- [Markdown Cheat Sheet](https://www.markdownguide.org/cheat-sheet/)


## Hints - useful aliases : 

```
alias comp='/path_to_project/CompostLyon'
alias rc='rails c'
alias rs='rails s'
alias spec='bundle exec rspec'
alias deploy='git push heroku main ; heroku run rails db:migrate'
alias sdeploy='git push staging staging:main ; heroku run rails db:migrate'
```
