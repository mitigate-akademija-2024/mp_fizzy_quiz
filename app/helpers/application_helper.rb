module ApplicationHelper

    def nav_btn
        'mr-6 text-blue-500 hover:text-blue-800'
    end

    def nav_btn_dissabled
        'mr-6 text-gray-400 cursor-not-allowed'
    end

    def basic_btn
        'inline-block rounded border border-indigo-600 px-4 py-1 text-sm font-medium text-indigo-600 hover:bg-indigo-600 hover:text-white focus:outline-none focus:ring active:bg-indigo-500'
    end
    
    def format_date(date)
        date.strftime("%F")
    end

end
