class FiguresController < ApplicationController
  
  get '/figures' do 
    @figures = Figure.all 
    erb :'/figures/index'
  end
  
  get '/figures/new' do 
    @titles = Title.all 
    @landmarks = Landmark.all
    erb :'/figures/new'
  end 
  
  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    @landmarks = @figure.landmarks
    @titles = @figure.titles

    erb :"/figures/show"
  end 
  
 post '/figures' do
    @figure = Figure.find_or_create_by(name: params[:figure][:name])

    title_ids = params[:figure][:title_ids]
    if title_ids != nil && !title_ids.empty?    
      title_ids.each do |title_id|
        @figure.titles << Title.find(title_id)
      end
    end

    if params[:title] != nil && params[:title][:name].size > 1
      @figure.titles << Title.create(name: params[:title][:name])
    end

    landmark_ids = params[:figure][:landmark_ids]
    if landmark_ids!= nil && !landmark_ids.empty?       
      landmark_ids.each do |landmark_id|
        @figure.landmarks << Landmark.find(landmark_id)
      end
    end

    if params[:landmark] != nil && params[:landmark][:name].size > 1
      @figure.landmarks << Landmark.create(name: params[:landmark][:name])
      @figure.save
    end

    @figure.save

    redirect "/figures/#{@figure.id}"
  end

  get "/figures/:id/edit" do
    @figure = Figure.find(params[:id])
    @titles = Title.all
    @landmarks = Landmark.all

    erb :"/figures/edit"
  end

  patch "/figures/:id" do
    @figure = Figure.find(params[:id])
    @figure.landmarks.clear
    @figure.titles.clear

    @figure.update(name: params[:figure][:name])

    title_ids = params[:figure][:title_ids]
    if title_ids != nil && !title_ids.empty?    
      title_ids.each do |title_id|
        @figure.titles << Title.find(title_id)
      end
    end

    if params[:title] != nil && params[:title][:name].size > 1
      @figure.titles << Title.create(name: params[:title][:name])
    end

    landmark_ids = params[:figure][:landmark_ids]
    if landmark_ids!= nil && !landmark_ids.empty?       
      landmark_ids.each do |landmark_id|
        @figure.landmarks << Landmark.find(landmark_id)
      end
    end

    if params[:landmark] != nil && params[:landmark][:name].size > 1
      @figure.landmarks << Landmark.create(name: params[:landmark][:name])
      @figure.save
    end

    @figure.save

    redirect "/figures/#{@figure.id}"
  end
end
