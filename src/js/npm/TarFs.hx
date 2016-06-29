package js.npm;

@:jsRequire('tar-fs')
extern class TarFs {
  @:overload(function(directory:String):js.node.stream.Writable.IWritable {})
  static function pack(directory:String, options:TarFsPackOptions):js.node.stream.Writable.IWritable;

  @:overload(function(toDirectory:String):js.node.stream.Readable.IReadable {})
  static function extract(toDirectory:String, options:TarFsExtractOptions):js.node.stream.Readable.IReadable;
}

typedef TarFsOptions<Stream> = {
  /**
    To ignore various files when packing or extracting add a ignore function to the options. ignore is also an alias for
    filter. Additionally you get header if you use ignore while extracting. That way you could also filter by metadata.
   **/
  @:optional var ignore(default, null):String->TarFsHeader->Bool;
  /**
    If you want to modify the headers when packing/extracting add a map function to the options
   **/
  @:optional var map(default, null):TarFsHeader->TarFsHeader;
  /**
    Similarly you can use mapStream incase you wanna modify the input/output file streams
   **/
  @:optional var mapStreams(default, null):Stream->TarFsHeader->Stream;
}

typedef TarFsExtractOptions = {
  > TarFsOptions<js.node.stream.Readable.IReadable>,
  dmode:Int,
  fmode:Int,
}

typedef TarFsPackOptions = {
  > TarFsOptions<js.node.stream.Writable.IWritable>,
  entries:Array<String>
}

typedef TarFsHeader = {
  name: String,
  size: Int,            // entry size. defaults to 0
  mode: Int,            // entry mode. defaults to to 0755 for dirs and 0644 otherwise
  mtime: Date,          // last modified date for entry. defaults to now.
  type: TarFsFileType,  // type of entry. defaults to file. can be:
  ?linkname: String,    // linked file name
  uid: Int,             // uid of entry owner. defaults to 0
  gid: Int,             // gid of entry owner. defaults to 0
  uname: String,        // uname of entry owner. defaults to null
  gname: String,        // gname of entry owner. defaults to null
  devmajor: Int,        // device major version. defaults to 0
  devminor: Int         // device minor version. defaults to 0
}

@:enum abstract TarFsFileType(String) {
  var File = 'file';
  var Link = 'link';
  var Symlink = 'symlink';
  var Directory = 'directory';
  var BlockDevice = 'block-device';
  var CharacterDevice = 'character-device';
  var Fifo = 'fifo';
  var ContiguousFile = 'contiguous-file';
}
