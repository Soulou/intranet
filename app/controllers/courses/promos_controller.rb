module Courses
  class PromosController < ApplicationController
    def index
    end

    def show(promo)
      @promo = promo
      documents = Document.only(:course_label).where(promo: promo)
      @courses = []
      documents.each do |d|
        @courses << d.course_label
      end
    end 
  end
end