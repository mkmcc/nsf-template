RUBY = ruby
RUBBER = rubber

doc:
	$(RUBBER) -df --warn all proposal

sections: doc
	$(RUBY) split.rb

clean:
	$(RM) -r submit
	$(RM) proposal.aux proposal.bbl proposal.blg proposal.log proposal.out proposal.pdf
