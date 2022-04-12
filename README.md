# virgil

![virgil](http://i.imgur.com/Nw9BRQg.png)

*It was created with the help of [maxdeviant](https://github.com/maxdeviant?tab=repositories) and the work on [Nouvion](https://github.com/merveilles/nouvion)*

*Wrriten up as of May 2, 2015*

Named after the [Roman poet](http://en.wikipedia.org/wiki/Virgil)... Virgil is a Slack bot, created in Ruby, that you can incorporate into your Slack.

*2022 note*

# THIS IS DEPRECATED. THERE ARE BETTER WAYS TO DO SLACK BOTS. THIS WAS LIKE ONE OF THE FIRST THINGS I EVER DID, AND IS KEPT FOR NOSTALGIA ONLY

<hr>

######<a href='#structure'>Structure</a>
######<a href='#started'>Getting Started</a>
######<a href='#forecast'>ForecastIO</a>
######<a href='#contributing'>Adding on / contributing</a>
######<a href='#deploy'>Deployment</a>

<hr>

**<a name='structure'>Structure</a>**

```Shell
.
|-- Gemfile
|-- Gemfile.lock
|-- LICENSE
|-- README.md
|-- Rakefile
|-- app.rb
|-- lib
|   |-- interpreter.rb
|   |-- modules
|       |-- module.calc.rb
|       |-- module.forecast.rb
|       |-- module.help.rb
|       |-- module.pathfind.rb
|       |-- module.recite.rb
|       |-- module.reference.rb
|       |-- module.self.rb
|       |-- module.whois.rb
|   |-- slack.rb
|   |-- virgil.rb
|-- spec
|   |-- slack
|       |-- slack_spec.rb
|   |-- spec_helper.rb
|   |-- virgil

4 directories, 19 files
```

Virgil is actually pretty simple. He runs out of `app.rb` at the root level. `interpreter.rb` is effectively your controller. It parses the message and acts accordingly, telling Virgil how to respond. `slack.rb` is what is doing the leg work in connecting to Slack's API.

When you boot the app up and get your server going, virgil is effectively listening and able to connect to [Slack's RTM API](https://api.slack.com/rtm) via a [Faye websocket](https://github.com/faye/faye-websocket-ruby).

Under `lib` in the `modules` folder is where things are broken out (e.g. `module.forecast.rb` is relevant to forecasting weather, `module.calc.rb` pertains to mathematical calculations and so on).

See *Adding on / contributing* for more on this.

**<a name='started'>Getting Started</a>**

For now, to get Virgil up and running locally, you're going to need a few things.

* Ensure that Ruby 2.2.1 is installed, this repo runs that locally.
* You need to set up the bot user on *[your Slack](https://my.slack.com/services/new/bot)*. Obviously, name your bot **virgil**. Yes, it MUST be virgil.
<img src='http://i.imgur.com/OquylQM.png' />
* You'll now see virgil as a team member on [your team directory](https://my.slack.com/team).
<img src='http://i.imgur.com/Q88caPd.png' />
* **Click on him and then on <i>configure</i>** and you can give virgil a description, an icon but more importantly, this is where his **API Token** is... it should look something like `xxxx-0123456789-someOTHERnumbers&letters`. Take note of that API token as you'll need it in a bit.
* `git clone git@github.com:johnakers/virgil.git`
* `cd virgil`
* create a new file at the root level called `.env`, refence the [dotenv guide](https://github.com/bkeepers/dotenv) if need be.
```Ruby
# in here, you'll need
SLACK_TOKEN="xxxx-0123456789-someOTHERnumbers&letters"
```
* `bundle`
* You should be able to then run `ruby app.rb` and a [Thin server](http://code.macournoyer.com/thin/) will start.
* Head over to `http://localhost:4567/` and you'll notice your terminal will start displaying the messages as they occur. Virgil should say that he's awake in whatever channel as listed as your `is_general` channel. If you do not have one, he may not work (never tested it). You can change this by [going into his code](https://github.com/johnakers/virgil/blob/master/lib/virgil.rb#L21-L32) and altering his `awake` and `sleep` messages, hide them, or alter the channel ids.
* in your `#general` channel, type `virgil` and he should respond
* `virgil help` will give a list of things he can do
<img src='http://i.imgur.com/0ksyjnO.png' />

**<a name='forecast'>ForecastIO</a>**

To get Virgil's `virgil forecast [city]` working... you'll need a [ForecastIO](http://forecast.io/) key. To get one, head over to [their API](https://developer.forecast.io/) and sign up, which will give you a key. It looks something like `380xxxxxa3xxxxx17xxxxxcb9`.

In your `.env` that you previously made
```Ruby
FORECAST_TOKEN="380xxxxxa3xxxxx17xxxxxcb9"
```

And you should be good to go.

**<a name='contributing'>Adding on / contributing</a>**

Hypothetically, you have Virgil up and running on your own. Now, you're wondering how to add on to him or, make him something else to work on your own.

First, figure out what term(s) and what text you expect. For instance `virgil [method] [relevant text]` is the format for pretty much everything.

Once you have a method, add that method to the case statement in `interpreter.rb` under `lib`. The `[relevant text]` is `text[1..-1].join(' ')`. Looking at the other cases is a good idea for reference. As noted in the comments above the case statement, keep your code here concise, with most of the work going on in your module.

Create another file under `modules` with the relevant name (e.g. `forecast.rb` is for forecasting the weather). Add the correct `require_relative` in `references.rb` under `modules` as well.

Test it out... prove it works... and you're good to go. If you really want to commit to this, a pull request will suffice.

**<a name='deploy'>Deployment</a>**

At time of writing this, I do not have virgil deployed anywhere. [`einhorn`](https://github.com/stripe/einhorn), recommneded by *maxdeviant* paired with deploying via [Linode](https://www.linode.com/) (or another 99.9% up service) seems to be the way to go. If you ping virgil multiple times while its running, you can potentially create multiple instances. einhorn allows you to push code while live and Linode has a good reputation for staying up and a relatively cheap cost. [Heroku](https://www.heroku.com/) apps, while popular for deploying with Ruby, go to sleep and using something like [kaffeine](http://kaffeine.herokuapp.com/), could have negative effects as mentioned before.

>Fortune favors the bold
