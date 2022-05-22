class Snippet < ApplicationRecord
    validates :user_id, :post_id, :code, presence: true
    validates :language, inclusion: { in: ['python', 'ruby', 'java'] }

    belongs_to(
        :post,
        class_name: 'Post',
        foreign_key: 'post_id',
        primary_key: 'id'
    )

    belongs_to(
        :user,
        class_name: 'User',
        foreign_key: 'user_id',
        primary_key: 'id'
    )

    def beautify_snippet
        keywords = ['def', 'class', 'if', 'else', 'end', 'elsif', 'elif', 'try', 'except', 'begin', 'rescue', 'return', 'for', 'while', 'in', 'do']
        sentences = []
        self.code.split("\r\n").each do |sent|
            if sent.strip[0] == '#'
                sentences << "<span style='color: #7F8487'>#{sent}</span>"
                next
            end
            words = []
            is_string = false
            starting_string_char = nil
            sent.split(' ').each.with_index do |word, i|
                if (word[0] == '\'' || word[0] == '"') && !is_string
                    is_string = true
                    starting_string_char = word[0]
                    words << "<span style='color: #95CD41'>#{word} "
                elsif (word[0] == '\'' || word[0] == '"') && is_string && starting_string_char == word[-1]
                    is_string = false
                    words[-1] += "#{word}</span>"
                elsif is_string
                    words[-1] += "#{word} "
                elsif word[-1] == ':' && keywords.include?(word[0...-1])
                    words << "<span style='color: #79DAE8'>#{word[0...-1]}</span><span>:</span>"
                elsif word[0] == ':'
                    words << "<span style='color: #FF8D29'>#{word}</span>"
                elsif keywords.include?(word)
                    words << "<span style='color: #79DAE8'>#{word}</span>"
                elsif sent.split(' ')[i-1] == 'class'
                    words << "<span style='color: #FFCD38'>#{word}</span>"
                elsif sent.split(' ')[i-1] == 'def'
                    words << "<span style='color: #0AA1DD'>#{word}</span>"
                else
                    words << word
                end
            end
            sentences << "<span>#{words.join(" ")}</span>"
        end
        return fix_indent(sentences.join("\r\n")).html_safe
    end

    def fix_indent(new_snippet)
        i = 0
        sentences = self.code.split("\r\n")
        indented_snippet = []
        while i < sentences.length
            j = 0
            x = new_snippet.split("\r\n")[i]
            while sentences[i][j] == ' '
                if x[7..10] == 'span'
                    x.insert(35, ' ')
                else
                    x.insert(6, ' ')
                end
                j += 1
            end
            indented_snippet << x
            i += 1
        end
        return indented_snippet.join("\r\n")
    end
end
