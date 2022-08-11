# CompositeContent

[![Build Status](https://travis-ci.com/notus-sh/composite_content.svg?branch=master)](https://travis-ci.com/notus-sh/composite_content)
[![Gem Version](https://badge.fury.io/rb/composite_content.svg)](https://badge.fury.io/rb/composite_content)

`CompositeContent` add capacities to your Rails application to manage complex contents made of blocks with ease.

## Some Background

Rich administrable contents used to be managed through WYSIWYG editors. This leaves you with a very poor control over what is allowed inside such content areas and how it will be rendered afterwards: `img` tags may include the full picture as base64 data or, like `iframe`s (pasted from videos or slides sharing code), can have hard-coded dimensions that makes them hard to manipulate in a responsive design; titles hierarchy may not semantically fit in every context where your content will be displayed; rogue CSS classes can be pasted from word processors without being noticed.  
The list of potential problems in a responsive and multi-channel world goes on…

An alternative to a monolithic WYSIWYG editor is to split your content into manageable chunks, or blocks. Each type of block can have its own properties and options and their definition should give you the ability to carefully manage their content to integrate it in various use cases and/or with other parts of your application. Such system should be extensible, so you can create new types of blocks to fit your needs.

For example:

- An image block can use your favorite attachment solution to retain picture information and be able to render it with the appropriate `src-set` attribute to accommodate screen resolutions you support.
- A video block can be rendered in a custom made player.
- A button block can survive your next redesign.
- Knowing your titles hierarchy inside a long content can gives you the ability to automate building of a table of content.
- A dedicated block type can help you to integrate descriptions of one or more of your products into a blog post.

`CompositeContent` provides basis for a composite content management on your models, in a way that can be compared to article construction on [medium.com](https://medium.com) or to the [WordPress Gutenberg editor](https://wordpress.org/gutenberg/), and aims to integrate well with your Rails application. It's voluntarily kept simple so you can plug your favorite tools in and style it to integrate well with your design.

## Installation

`CompositeContent` is distributed as a gem and available on [rubygems.org](https://rubygems.org/gems/composite_content) so you can add it to your `Gemfile` or install it manually with:

```ruby
gem install composite_content
```

Once the gem is installed, you need to integrate it with your Rails application.

```shell
# Copy CompositeContent's engine files into your app:
# - Views to app/views/composite_content
# - Database migrations to db/migrate
$ rails g composite_content:install

# Apply migrations
$ rails db:migrate 
```

**Important:** For forms to work, you also need to integrate assets from the [Cocooned gem](https://github.com/notus-sh/cocooned) with yours. As there is multiple ways to do so, wether you use Sprockets, webpacker/shakapacker or importmaps, we won't describe this step in details here.

## Usage

In your models, you can declare one or more CompositeContent per model.

```ruby
class Article < ApplicationRecord
  # You can use the default content slot name (:composite_content)…
  has_composite_content
end

class Page < ApplicationRecord
  # …or give it a name that is explicit for you.
  has_composite_content :main
  
  # You can specify what kinds of blocks you accept in a content slot.
  has_composite_content :aside, types: %w(CompositeContent::Blocks::Text)
end
```

### Strong Parameters

In your controllers, allow composite content attributes with:

```ruby
class ArticleController < ApplicationController
  # […]
  def article_params
    params.require(:article)
          .permit(:title,
                  composite_content_attributes: Article.strong_parameters_for_composite_content)
  end
end

class PageController < ApplicationController
  # […]
  def page_params
    params.require(:page)
          .permit(:title,
                  main_attributes: Page.strong_parameters_for_main,
                  aside_attributes: Page.strong_parameters_for_aside)
  end
end
```

### Views

In your forms, make composite content editable with:

```erbruby
<%= form.fields_for :composite_content do |composite_content_form| %>
  <%= render 'composite_content/slot/form', form: composite_content_form %>
<% end %>
```

In your views, render the content of a slot with:

```erbruby
<%= composite_content_render_slot(article.composite_content) %>

<%= composite_content_render_slot(page.main) %>
<%= composite_content_render_slot(page.aside) %>
```

## Contributing

Bug reports and pull requests are welcome on GitHub at <https://github.com/notus-sh/composite_content>.
