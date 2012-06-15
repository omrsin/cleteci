# encoding: utf-8

require 'spec_helper'

describe "Contact Pages" do

	subject { page }

	describe "Contactos page" do
  	before { visit contacto_path }
  	it { should have_selector('title', text: "CLETECI | Contáctanos") }
  end
end
