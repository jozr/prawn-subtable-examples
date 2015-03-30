#Prawn Subtable Examples
This code demonstates the creating of a subtables within nested data using [Prawn](https://github.com/prawnpdf/prawn).

##Manual
Clone this repository:

```console
$ git clone https://github.com/jozw/prawn-subtable-examples
```

Bundle the dependencies:

```console
$ bundle install
```

Start interactive Ruby shell:

```console
$ irb
```

Now, create the PDF and save it where you please.

```ruby
require './main_pdf.rb'
pdf = MainPdf.new
pdf.render_file '/Users/YOUR_USERNAME/Desktop/foobar.pdf' 
```

##License
MIT
