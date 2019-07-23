class PublicationsController < ApplicationController
  # GET /publications
  # GET /publications.json
  def index

    publisher = Publisher.where(name: params[:publisher_id])

    publications = Publication.where(publisher_id: publisher)

    render json: publications.as_json
  end

  # GET /publications/1
  # GET /publications/1.json
  def show
    #@publication = Publication.find(params[:id])
    #@issues = @publication.issues.where( :issue_states => {:name => 'released'})
    #render json: @issues

    publication = Publication.find_by_product_code(params[:id])

    state = IssueState.find_by_name('Released')

    issues = Issue.where(:publication_id => publication, :issue_state_id => state)
    render json: issues.as_json({:except => :pdf_zip})

  end

  # GET /publications/new
  # GET /publications/new.json
  #def new
  #  @publication = Publication.new
  #
  #  respond_to do |format|
  #    format.html # new.html.erb
  #    format.json { render json: @publication }
  #  end
  #end

  ## GET /publications/1/edit
  #def edit
  #  @publication = Publication.find(params[:id])
  #end

  # POST /publications
  # POST /publications.json
  #def create
  #  @publication = Publication.new(params[:publication])
  #
  #  respond_to do |format|
  #    if @publication.save
  #      format.html { redirect_to @publication, notice: 'Publication was successfully created.' }
  #      format.json { render json: @publication, status: :created, location: @publication }
  #    else
  #      format.html { render action: "new" }
  #      format.json { render json: @publication.errors, status: :unprocessable_entity }
  #    end
  #  end
  #end

  # PUT /publications/1
  # PUT /publications/1.json
  #def update
  #  @publication = Publication.find(params[:id])
  #
  #  respond_to do |format|
  #    if @publication.update_attributes(params[:publication])
  #      format.html { redirect_to @publication, notice: 'Publication was successfully updated.' }
  #      format.json { head :no_content }
  #    else
  #      format.html { render action: "edit" }
  #      format.json { render json: @publication.errors, status: :unprocessable_entity }
  #    end
  #  end
  #end

  # DELETE /publications/1
  # DELETE /publications/1.json
  #def destroy
  #  @publication = Publication.find(params[:id])
  #  @publication.destroy
  #
  #  respond_to do |format|
  #    format.html { redirect_to publications_url }
  #    format.json { head :no_content }
  #  end
  #end
end
