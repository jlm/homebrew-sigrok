class Libsigrokdecode < Formula
  homepage "https://sigrok.org/"
  url "https://sigrok.org/download/source/libsigrokdecode/libsigrokdecode-0.5.2.tar.gz"
  sha256 "e08d9e797c54eccf3144da631b6e5f1498ac531e51520428df537a1da82583f0"
  head "git://sigrok.org/libsigrokdecode", :using => Class.new(GitDownloadStrategy) { def support_depth?; false; end }

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "pkg-config" => :build
  depends_on "glib"
  depends_on "jlm/sigrok/libsigrok"
  depends_on "python"

  def install
    ENV.delete "PYTHONPATH"
    if build.head?
      system "./autogen.sh"
    end
    py_ver = Formula["python"].pkg_version.to_s[0..2] # e.g "3.4"
    ENV.append_path "PKG_CONFIG_PATH", "#{HOMEBREW_PREFIX}/Frameworks/Python.framework/Versions/#{py_ver}/lib/pkgconfig/"
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end
end
