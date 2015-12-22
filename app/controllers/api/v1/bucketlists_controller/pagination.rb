module Api
  module V1
    class Pagination
      def self.set_limit(limit)
        case 
          when limit.nil? || limit.to_i < 0
            20
          when limit.to_i > 100
            100
          else
            limit.to_i
        end
      end

      def self.paginate(search_result, limit = nil, pages = nil)
        total_items = limit.to_i * pages.to_i
        offset = total_items - limit.to_i 
        display = search_result.limit(limit).offset(offset)
        result_message(display)
      end

      def self.result_message(result) 
        if result.empty? || result.blank?
          return "error: no results found for query" 
        else      
          return result
        end
      end    
    end
  end
end
