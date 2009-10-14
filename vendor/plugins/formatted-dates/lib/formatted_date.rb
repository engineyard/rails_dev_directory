module FormattedDate
  
  def self.included(base) 
     base.extend FormatDatesMethod
   end

  
  module FormatDatesMethod
    
    TIMESTAMPS = [:created_at, :updated_at, :created_on, :updated_on]
    
    def format_dates(args = [], options = {})
        format = options[:format] || "%e %B, %Y"
        filter_date = options[:filter] || nil
        as = options[:as] || nil
        today = options[:today] || nil
        args = [args].flatten
        
        if args.include?(:timestamps)
          TIMESTAMPS.each do |timestamp|
            args << timestamp
          end
        end
      
      args.each do |date_method|
        class_eval "
          def #{date_method}_formatted
            return \"\" if respond_to?(:#{date_method}) and #{date_method}.nil?
            return_date = #{date_method}.strftime(\"#{format}\").strip if respond_to?(:#{date_method})
            "+ (today ? "return_date = #{date_method}.strftime(\"#{today}\").strip if respond_to?(:#{date_method}) and #{date_method}.to_date == Date.today" : '')+"
            "+(filter_date ? "return_date = return_date.#{filter_date}" : '')+"
            return_date
          end
        "
      end
      
      unless args.empty?
        if as
          class_eval "alias_method :#{as}, :#{args.first}_formatted"
        end
      end
    end

  end
  
end