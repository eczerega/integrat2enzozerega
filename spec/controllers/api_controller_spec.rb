require 'rails_helper'

RSpec.describe HomeController, type: :controller do

#@update = Update.create(version: 1, date: Time.now)
  describe "Request parametros correctos" do
    it 'verifica que el estado sea correcto cuando el request se envía bien' do
    params = {'tag' => 'santiago', 'access_token' => '1442649438.1677ed0.da39352fcbe04712ba35f360d1a98762'}
      post :buscar, params.merge(format: :json)
      json = JSON.parse(response.body)
      puts json
      expect(response).to have_http_status(200)
    end
  end






  describe "Request con token incorrecto" do
    it 'verifica que el token sea correcto' do
    params = {'tag' => 'santiago', 'access_token' => 'token malo'}
      post :buscar, params.merge(format: :json)
      json = JSON.parse(response.body)
      expect(response).to have_http_status(400)
    end
  end

  describe "Request con tag presente" do
    it 'verifica que el tag esté presente' do
    params = {'access_token' => '1442649438.1677ed0.da39352fcbe04712ba35f360d1a98762'}
      post :buscar, params.merge(format: :json)
      json = JSON.parse(response.body)
      expect(response).to have_http_status(400)
    end
  end

  describe "Request sin tag presente y token malo" do
    it 'verifica que todos los parámetros estén bien' do
    params = {'access_token' => 'token malo'}
      post :buscar, params.merge(format: :json)
      json = JSON.parse(response.body)
      expect(response).to have_http_status(400)
    end
  end

  describe "Respuesta con metadata y posts" do

    it 'verifica que la respuesta, de ser correcta, siempre contenga los objetos pedidos' do
    params = {'tag' => 'santiago', 'access_token' => '1442649438.1677ed0.da39352fcbe04712ba35f360d1a98762'}
      post :buscar, params.merge(format: :json)
      json = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(json['metadata']['total']).should_not be_nil
      #expect(json['metadata']['total']).be_kind_of(Integer) 
      expect(json['posts']).should_not be_nil
    end
  end

  describe "Respues con metadata y posts no vacíos" do

    it 'verifica la estructura de la respuesta dada' do
    params = {'tag' => 'santiago', 'access_token' => '1442649438.1677ed0.da39352fcbe04712ba35f360d1a98762'}
      post :buscar, params.merge(format: :json)
      json = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(json['metadata']['total']).should_not be_nil
      if json['posts'][0] != nil
        json['posts'][0]['tags'].should_not be_nil
        json['posts'][0]['tags'].should_not be_an(Integer)
        json['posts'][0]['username'].should_not be_nil
        json['posts'][0]['username'].should be_a(String)
        json['posts'][0]['likes'].should_not be_nil
        json['posts'][0]['likes'].should be_an(Integer)
        json['posts'][0]['url'].should_not be_nil
        json['posts'][0]['url'].should be_a(String)
        json['posts'][0]['caption'].should_not be_nil
        json['posts'][0]['caption'].should be_a(String)
      end
    end
  end


end
