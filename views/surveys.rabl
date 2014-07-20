object @representation => :_links

child @representation.self, :root => "self" do
	attributes :href
end

child @representation.next, :root => "next" do
	attributes :href
end