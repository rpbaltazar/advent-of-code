require 'digest/md5'

def digest_matches?(index, regex)
  Digest::MD5.hexdigest("#{@input}#{index}") =~ regex
end

@input = 'bgvyzdsv'

index = 0
index += 1 until digest_matches?(index, /^00000.*/)
puts index

index = 0
index += 1 until digest_matches?(index, /^000000.*/)
puts index
