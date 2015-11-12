# use ghostscript to split the main pdf file into separate sections to upload
# into fastlane
#

# first, read the page ranges from the log file.  the tex document
# writes out things like
#
#  B-START is 2
#  B-END is 2
#
# to the log.  this is probably pretty fragile, and not-well-tested,
# but it worked for me.  this also is pretty ugly, heavily-duplicated
# code... forgive me?
#
a = Array.new
b = Array.new
c = Array.new
d = Array.new
e = Array.new
f = Array.new
g = Array.new
h = Array.new
i = Array.new
j = Array.new

File.open('proposal.log').each do |line|
  if line.match(/A-START/) or line.match(/A-END/)
    a << line.split[-1].to_i
  elsif line.match(/B-START/) or line.match(/B-END/)
    b << line.split[-1].to_i
  elsif line.match(/C-START/) or line.match(/C-END/)
    c << line.split[-1].to_i
  elsif line.match(/D-START/) or line.match(/D-END/)
    d << line.split[-1].to_i
  elsif line.match(/E-START/) or line.match(/E-END/)
    e << line.split[-1].to_i
  elsif line.match(/F-START/) or line.match(/F-END/)
    f << line.split[-1].to_i
  elsif line.match(/G-START/) or line.match(/G-END/)
    g << line.split[-1].to_i
  elsif line.match(/H-START/) or line.match(/H-END/)
    h << line.split[-1].to_i
  elsif line.match(/I-START/) or line.match(/I-END/)
    i << line.split[-1].to_i
  elsif line.match(/J-START/) or line.match(/J-END/)
    j << line.split[-1].to_i
  end
end


# hash table for the sections in the proposal
#
@files = [ ['a', 'cover-sheet',                    a, nil ],
           ['b', 'project-summary',                b, true],
           ['c', 'table-of-contents',              c, nil ],
           ['d', 'project-description',            d, true],
           ['e', 'references-cited',               e, true],
           ['f', 'biographical-sketches',          f, nil ],
           ['g', 'budget-justification',           g, true],
           ['h', 'current-pending-support',        h, true],
           ['i', 'facilities-equipment-resources', i, true],
           ['j', 'special-info-supplementary-doc', j, true] ]


# ghostscript command to split out part of a pdf file.  takes a page
# range, input filename, and output filename
#
def compile_cmd(first_page, last_page, infilename, outfilename)
  cmd1 = 'gs -dBATCH -dNOPAUSE -sDEVICE=pdfwrite'
  cmd2 = "-dFirstPage=#{first_page.to_s} -dLastPage=#{last_page.to_s}"
  cmd3 = "-sOutputFile=#{outfilename} #{infilename}"

  cmd1 + ' ' + cmd2 + ' ' + cmd3
end

# run (or print) a command.  for debugging
#
def run_command(str)
  puts str
  system str
end


# split the main document into sections.  save them to the directory submit/
#
run_command('mkdir -p submit')

@files.each do |char, title, pages, keep|
  if keep
    first, last = pages
    run_command(compile_cmd(first, last, 'proposal.pdf',
                            "submit/#{char}--#{title}.pdf"))
  end
end

# Local Variables:
# fill-column: 150
# End:
