module ApplicationHelper
  def format_brazilian_number(number, precision: 2)
    return "0,#{'0' * precision}" if number.nil? || number.zero?
    
    # Format with Brazilian locale: dot for thousands, comma for decimals
    # First format with precision (using default decimal point)
    formatted = number_with_precision(number, precision: precision)
    
    # Split into integer and decimal parts
    parts = formatted.to_s.split('.')
    integer_part = parts[0]
    decimal_part = parts[1] || '0' * precision
    
    # Add thousands separators (dots) to integer part
    integer_with_dots = integer_part.reverse.gsub(/(\d{3})(?=\d)/, '\\1.').reverse
    
    # Combine with comma for decimal separator
    "#{integer_with_dots},#{decimal_part}"
  end
end
