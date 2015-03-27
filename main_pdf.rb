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
                'cuatro' => { 'one' => [[1, 2, 3, 4]], 'two' => [[1, 2, 3, 4]], 'three' => [[1, 2, 3, 4], [1, 2, 3, 4], [1, 2, 3, 4]] },
                'cinco' => { 'one' => [[1, 2, 3, 4], [1, 2, 3, 4]], 'two' => [[1, 2, 3, 4]], 'three' => [[1, 2, 3, 4]] },
                'seis' => { 'one' => [[1, 2, 3, 4]], 'two' => [[1, 2, 3, 4]], 'three' => [[1, 2, 3, 4]], 'four' => [[1, 2, 3, 4]], 'five' => [[1, 2, 3, 4]] }}

    data = []
    table_data = []

    numbers.each do |spanish, elem|
      needed_count = 1

      elem.each do |english, int|
        needed_count += int.length / 12
        count = 1

        int.each_slice(12) do |group|
          count += 1
          english_row = [{ content: english, colspan: 4 }]
          english_table = make_table(group.unshift(english_row), header: true, width: WIDTH)
          table_data << [{ content: english_table, colspan: 4 }]
          break if count > needed_count

          spanish_row = [{ content: spanish, colspan: 4 }]
          spanish_table = make_table([spanish_row] + table_data, header: true, width: WIDTH)
          data << [{ content: spanish_table, colspan: 4 }]
          table_data = table_data.clear
        end
      end

      spanish_row = [{ content: spanish, colspan: 4 }]
      spanish_table = make_table([spanish_row] + table_data, header: true, width: WIDTH)
      data << [{ content: spanish_table, colspan: 4 }]
      table_data = table_data.clear
    end

    table([HEADER] + data, header: true, width: WIDTH)
  end
end
