class BlogDataSetsController < ApplicationController
  # GET /blog_data_sets
  # GET /blog_data_sets.json
  def index
    @blog_data_sets = BlogDataSet.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @blog_data_sets }
    end
  end

  # GET /blog_data_sets/1
  # GET /blog_data_sets/1.json
  def show
    @blog_data_set = BlogDataSet.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @blog_data_set }
    end
  end

  # GET /blog_data_sets/new
  # GET /blog_data_sets/new.json
  def new
    @blog_data_set = BlogDataSet.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @blog_data_set }
    end
  end

  # GET /blog_data_sets/1/edit
  def edit
    @blog_data_set = BlogDataSet.find(params[:id])
  end

  # POST /blog_data_sets
  # POST /blog_data_sets.json
  def create
    @blog_data_set = BlogDataSet.new(params[:blog_data_set])

    respond_to do |format|
      if @blog_data_set.save
        format.html { redirect_to @blog_data_set, notice: 'Blog data set was successfully created.' }
        format.json { render json: @blog_data_set, status: :created, location: @blog_data_set }
      else
        format.html { render action: "new" }
        format.json { render json: @blog_data_set.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /blog_data_sets/1
  # PUT /blog_data_sets/1.json
  def update
    @blog_data_set = BlogDataSet.find(params[:id])

    respond_to do |format|
      if @blog_data_set.update_attributes(params[:blog_data_set])
        format.html { redirect_to @blog_data_set, notice: 'Blog data set was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @blog_data_set.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blog_data_sets/1
  # DELETE /blog_data_sets/1.json
  def destroy
    @blog_data_set = BlogDataSet.find(params[:id])
    @blog_data_set.destroy

    respond_to do |format|
      format.html { redirect_to blog_data_sets_url }
      format.json { head :no_content }
    end
  end
end
