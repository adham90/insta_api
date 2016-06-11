     Prefix Verb   URI Pattern             Controller#Action
sidekiq_web        /sidekiq                Sidekiq::Web
 count_bugs GET    /bugs/count(.:format)   bugs#count
       bugs GET    /bugs(.:format)         bugs#index
            POST   /bugs(.:format)         bugs#create
        bug GET    /bugs/:number(.:format) bugs#show
            DELETE /bugs/:number(.:format) bugs#destroy
