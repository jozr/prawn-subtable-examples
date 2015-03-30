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
                'seis' => { 'one' => [[1, 2, 3, 4]], 'two' => [[1, 2, 3, 4]], 'three' => [[1, 2, 3, 4]], 'four' => [[1, 2, 3, 4]], 'five' => [[1, 2, 3, 4]], 'six' => [[1, 2, 3, 4]], 'seven' => [[1, 2, 3, 4]], 'eight' => [[1, 2, 3, 4]], 'nine' => [[1, 2, 3, 4]], 'ten' => [[1, 2, 3, 4]], 'eleven' => [[1, 2, 3, 4]], 'twelve' => [[1, 2, 3, 4]], 'thirteen' => [[1, 2, 3, 4]] }}

    data = []
    table_data = []
    s_needed_count = 1

    numbers.each do |spanish, elem|
      s_needed_count += elem.length / 10
      s_count = 1
      e_needed_count = 1
      elem.each_slice(10) do |groups|
        s_count += 1
        groups.each do |english, int|
          e_needed_count += int.length / 12
          e_count = 1
          int.each_slice(12) do |group|
            e_count += 1
            table_data << [{ content: english_table(english, group), colspan: 4 }]
            break if e_count > e_needed_count
            data << [{ content: spanish_table(spanish, table_data), colspan: 4 }]
            table_data.clear
          end
        end
        data << [{ content: spanish_table(spanish, table_data), colspan: 4 }]
        table_data.clear
        break if s_count < s_needed_count
        main_table(data)
        data.clear
      end
    end
    main_table(data)
    data.clear
  end

  def english_table(header, content)
    header_row = [{ content: header, colspan: 4 }]
    make_table(content.unshift(header_row), header: true, width: WIDTH)
  end

  def spanish_table(header, content)
    header_row = [{ content: header, colspan: 4 }]
    make_table([header_row] + content, header: true, width: WIDTH)
  end

  def main_table(content)
    table([HEADER] + content, header: true, width: WIDTH)
  end
end
