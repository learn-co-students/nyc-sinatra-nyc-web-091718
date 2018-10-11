class FiguresController < ApplicationController

  get '/' do
    "Homepage"
  end

  get '/figures' do
    @figures = Figure.all

    erb :'figures/index'
  end

  get '/figures/new' do
    @landmarks = Landmark.all
    @titles = Title.all

    erb :'figures/new'
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])

    erb :'figures/show'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    @landmarks = Landmark.all
    @titles = Title.all

    erb :'figures/edit'
  end

  post '/figures' do
    @figure = Figure.create(params[:figure])


    if !params["title"]["name"].empty?
          @figure.titles << Title.create(name: params["title"]["name"])
    end

    if !params["landmark"]["name"].empty?
          @figure.landmarks << Landmark.create(name: params["landmark"]["name"], year_completed: params["landmark"]["year_completed"])
    end

    redirect "figures/#{@figure.id}"
  end

  patch "/figures/:id" do
    @figure = Figure.find(params[:id])

    if !params[:figure].keys.include?("landmark_ids")
      params[:figure]["landmark_ids"] = []
    end
    if !params[:figure].keys.include?("title_ids")
      params[:figure]["title_ids"] = []
    end

    @figure.update(params["figure"])

    if !params["landmark"]["name"].empty?
      @figure.landmarks << Landmark.create(name: params["landmark"]["name"], year_completed: params["landmark"]["year_completed"])
    end

    if !params["title"]["name"].empty?
      @figure.titles << Title.create(name: params["title"]["name"])
    end

    redirect "figures/#{@figure.id}"
  end

end ### End of FiguresController
