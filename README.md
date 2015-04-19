# virgil

*This is a work in progress. It was created with the help of [maxdeviant](https://github.com/maxdeviant?tab=repositories) and the work on [Nouvion](https://github.com/merveilles/nouvion), a Slack bot for Merveilles.*

*This README is written up as of April 19, 2015... it will most likely change.*

Named after the [Roman poet](http://en.wikipedia.org/wiki/Virgil)... Virgil is a Slack bot, created in Ruby, that you can incorporate into your Slack.

######<a href='#structure'>Structure</a>
######<a href=''>Getting Started</a>
######<a href=''>ForecastIO</a>
######<a href=''>Adding on / contributing</a>

<hr>

**<a name='structure'>Structure</a>**

```Shell
.
|-- Gemfile
|-- Gemfile.lock
|-- LICENSE
|-- Rakefile
|-- app.rb
|-- lib
|   |-- interpreter.rb
|   |-- modules
|       |-- forecast.rb
|       |-- pathfind.rb
|       |-- reference.rb
|       |-- whois.rb
|   |-- slack.rb
|   |-- virgil.rb
|-- spec
|   |-- slack
|       |-- slack_spec.rb
|   |-- spec_helper.rb
|   |-- virgil
|-- views
|   |-- index.erb

6 directories, 16 files
```

Virgil is actually pretty simple. He runs out of `app.rb` at the root level. `interpreter.rb` is effectively your controller. It parses the message and acts accordingly, telling Virgil how to respond. `slack.rb` is what is doing the leg work in connecting to Slack's API.

Under `lib` in the `modules` folder is where things are broken out (e.g. `forecast.rb` is relevant to forecasting weather).

See *Adding on / contributing* for ore on this.

**Getting Started**

For now, to get Virgil up and running locally, you're going to need a few things.

* Ensure that Ruby 2.2.1 is installed.
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
* You should be able to then run `ruby app.rb` and a [Thin server](http://code.macournoyer.com/thin/) will start.
* Head over to `http://localhost:4567/` and you'll notice your terminal will start displaying the messages as they occur. Virgil should say that he's awake in your `#general` channel. If you do not have one, he will not work. You can change this by [going into his code](https://github.com/johnakers/virgil/blob/master/lib/virgil.rb#L21-L30) and altering his `awake` and `sleep` messages, hide them, or alter the channel ids.
* in your `#general` channel, type `virgil` and he should respond
* `virgil help` will give a list of things he can do
<img src='http://i.imgur.com/fIZq00v.png' />

**ForecastIO**

To get Virgil's `virgil forecast [city]` working... you'll need a [ForecastIO](http://forecast.io/) key. To get one, head over to [their API](https://developer.forecast.io/) and sign up, which will give you a key. It looks something like `380xxxxxa3xxxxx17xxxxxcb9`.

In your `.env` that you previously made
```Ruby
FORECAST_TOKEN="380xxxxxa3xxxxx17xxxxxcb9"
```

And you should be good to go.

**Adding on / contributing**

Hypothetically, you have Virgil up and running on your own. Now, you're wondering how to add on to him or, make him something else to work on your own.

First, figure out what term and what text you expect. For instance `virgil [method] [relevant text]` is the format for pretty much everything.

Once you have a method, add that method to the case statement in `interpreter.rb` under `lib`. The `[relevant text]` is `text[1..-1].join(' ')`. Looking at the other cases is a good idea for reference. As noted in the comments above the case statement, keep your code here concise, with most of the work going on in your module.

Create another file under `modules` with the relevant name (e.g. `forecast.rb` is for forecasting the weather). Add the correct `require_relative` in `references.rb` under `modules` as well.

Test it out... prove it works... and you're good to go. If you really want to commit to this, a pull request will suffice.

>Fortune favors the bold
