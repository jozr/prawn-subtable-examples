require 'prawn'
require_relative './vendor/bundle/gems/prawn-table-0.1.2/lib/prawn/table'
 
class MainPdf < Prawn::Document
 
  HEADER = ['I', 'II', 'III', 'IV']
  WIDTH = 200

  def initialize
    super(page_layout: :landscape)

    numbers = { 'uno' => { 'one' => [[1, 2, 3, 4]], 'two' => [[1, 2, 3, 4]], 'three' => [[1, 2, 3, 4]], 'four' => [[1, 2, 3, 4]] }, 
                'dos' => { 'one' => [[1, 2, 3, 4], [1, 2, 3, 4], [1, 2, 3, 4], [1, 2, 3, 4], [1, 2, 3, 4], [1, 2, 3, 4], [1, 2, 3, 4]], 'two' => [[1, 2, 3, 4]], 'three' => [[1, 2, 3, 4]] }, 
                'tres' => { 'one' => [[1, 2, 3, 4]], 'two' => [[1, 2, 3, 4]], 'three' => [[1, 2, 3, 4], [1, 2, 3, 4], [1, 2, 3, 4], [1, 2, 3, 4], [1, 2, 3, 4], [1, 2, 3, 4], [1, 2, 3, 4], [1, 2, 3, 4], [1, 2, 3, 4], [1, 2, 3, 4], [1, 2, 3, 4], [1, 2, 3, 4], [1, 2, 3, 4], [1, 2, 3, 4], [1, 2, 3, 4], [1, 2, 3, 4], [1, 2, 3, 4], [1, 2, 3, 4], [1, 2, 3, 4], [1, 2, 3, 4]] },
                'cuatro' => { 'one' => [[1, 2, 3, 4]], 'two' => [[1, 2, 3, 4]], 'three' => [[1, 2, 3, 4], [1, 2, 3, 4], [1, 2, 3, 4]]},
                'cinco' => { 'one' => [[1, 2, 3, 4], [1, 2, 3, 4]], 'two' => [[1, 2, 3, 4]], 'three' => [[1, 2, 3, 4]] },
                'seis' => { 'one' => [[1, 2, 3, 4]], 'two' => [[1, 2, 3, 4]], 'three' => [[1, 2, 3, 4]] }}

    data = []

    numbers.each do |spanish, elem|
      table_data = []

      elem.each do |english, int|
        english_row = [{ content: english, colspan: 4 }]
        sub_table = make_table(int.unshift(english_row), header: true, width: WIDTH)
        table_data << [{ content: sub_table, colspan: 4 }]
      end

      spanish_row = [{ content: spanish, colspan: 4 }]
      spanish_table = make_table([spanish_row] + table_data, header: true, width: WIDTH)
      data << [{ content: spanish_table, colspan: 4}]
    end

    table([HEADER] + data, header: true, width: WIDTH)
  end
end
