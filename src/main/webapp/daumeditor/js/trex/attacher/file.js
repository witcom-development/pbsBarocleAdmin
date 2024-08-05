/**
 * @fileoverview 
 * File 업로드 관련 Source
 * Trex.Tool.File - UI,
 * Trex.Attacher.File,
 * Trex.Attachment.File,
 * default configuration를 포함하고 있다.
 */
TrexConfig.addTool(
	"file",
	{
		disabledonmobile: _TRUE,
		wysiwygonly: _TRUE,
		sync: _FALSE,
		status: _FALSE
	}
);

TrexMessage.addMsg({
	'@file.title': "파일"
});

/**
 * Trex.Tool.File
 * @class
 * @extends Trex.Tool
 */
Trex.Tool.File = Trex.Class.create({
	/** ignore */
	$const: {
		__Identity: 'file'
	},
	/** ignore */
	$extend: Trex.Tool,
	oninitialized: function() {
		var _editor = this.editor;
		this.weave.bind(this)(
			new Trex.Button(this.buttonCfg), 
			_NULL,
			function() {
				_editor.getSidebar().getAttacher("file").execute();
			}
		);
	}
});

TrexConfig.addAttacher(
	"file",
	{
		multiple: _TRUE,
		multipleuse: _FALSE,
		checksize: _TRUE,
		boxonly: _FALSE,
		wysiwygonly: _TRUE,
		objattr: {},
		features: { left:250, top:65, width:350, height:300, location:'no', directories:'no', resizeable:'no' },
		/*popPageUrl: "#host#path/pages/trex/image.html"*/
		popPageUrl: "#host/daumeditorFileUploadPopup2.do"
	},
	function(root){
		var _config = TrexConfig.getAttacher("file", root);
		_config.popPageUrl = TrexConfig.getUrl(_config.popPageUrl);
		_config.features = TrexConfig.getPopFeatures(_config.features);
	}
);

/**
 * Trex.Attacher.File
 * @class
 * @extends Trex.Attacher
 */
Trex.Attacher.File = Trex.Class.create({
	$const: {
		__Identity: 'file'
	},
	$extend: Trex.Attacher,
	name: 'file',
	title: TXMSG("@file.title"),
	canModified: _FALSE,
	canResized: _TRUE,
    matchRegexStartTag: /<(\w+)/,// 첨부시에 dispHtml을 기준으로 속성 및 스타일을 적용 할 태그를 찾을 때 사용
	oninitialized: function() {
		
	},
	getKey: function(data) {
		return data.imageurl;
	},
	getDataForEntry: function(data) {
		data.imageurl = this.encodeSpaceInUrl(data.fileurl);
		data.originalurl = this.encodeSpaceInUrl(data.originalurl);
		data.attachurl = this.encodeSpaceInUrl(data.attachurl);
		data.thumburl = data.thumburl || data.fileurl.replace(/\/file\//gm, '/P150x100/');
		  
		if(!data.dispElId) {
			data.dispElId = Trex.Util.getDispElId();
		}
		var _seq = ((data.tmpSeq)? this.entryBox.syncSeq(data.tmpSeq): this.entryBox.newSeq());
		var _data = Object.extend({ 
			dataSeq: _seq
		}, data); //NOTE: Cuz IE
		return _data;
	},
	createEntry: function(data, type) {
		return this.createAttachment(data, type);
 	},
	encodeSpaceInUrl: function(url){
		if ( !url ) {
			return ;
		}
		
		return url.replace(/ /g, "%20");	
	},
	execAttach: function(data, type) {
		var _entry = this.createEntry(this.getDataForEntry(data), type);
		_entry.execRegister();
	},
	execReload: function(data, content, type) {
		var _entry = this.createEntry(this.getDataForEntry(data, content), type);
		_entry.execReload();
	}
});

/**
 * Trex.Attachment.File 
 * 
 *  @example
 *  	data = {
 *			attachurl: "string",
 *			filename: "string",
 *			filesize: number,
 *			filemime: "string"
 *		}
 * @class
 * @extends Trex.Attachment
 */
Trex.Attachment.File = Trex.Class.create({
	/** @ignore */
	$const: {
		__Identity: 'file'
	},
	/** @ignore */
	$extend: Trex.Attachment,
	getFieldAttr: function(data) {
		return {
			name: 'tx_attach_file',
			value: [data.imageurl, data.filename, data.filesize].join('|')
		};
	},
	getBoxAttr: function(data) {
		var _rectangle = data.width ? data.width + "x" + data.height + " / " : ""; 
		return {
			name: data.filename + " (" +  _rectangle + data.filesize.toByteUnit() + ")"
		};
	},
	
		
	/**
	 * object의 style 값을 가져온다.
	 * @function
	 */
	getObjectStyle: function(data) {
		var _objstyle = {};
		if(this.actor.config.objstyle) {
			_objstyle = Object.extend(_objstyle, this.actor.config.objstyle);
		}
		if(data.imagealign) {
			var _objectStyle = {
				"L": Trex.Tool.AlignLeft,
				"C": Trex.Tool.AlignCenter,
				"FL": Trex.Tool.AlignRight,
				"FR": Trex.Tool.AlignFull
			}[data.imagealign];
			if (_objectStyle && _objectStyle.__TextModeProps && _objectStyle.__TextModeProps['file']) {
				_objstyle = Object.extend(_objstyle, _objectStyle.__TextModeProps['button']['style']);
			}
		}
		return _objstyle;
	},
	/**
	 * object를 감싸고 있는 paragraph tag 의 style 값을 가져온다.
	 * @function
	 */
	getParaStyle: function(data) {
		var _parastyle = Object.extend({}, this.actor.config.parastyle || this.actor.config.defaultstyle);
		if(data.imagealign) {
			var _objectStyle = {
				"L": Trex.Tool.AlignLeft,
				"C": Trex.Tool.AlignCenter,
				"FL": Trex.Tool.AlignFull,
				"FR": Trex.Tool.AlignRight
			}[data.imagealign];
			if (_objectStyle && _objectStyle.__TextModeProps && _objectStyle.__TextModeProps['paragraph']) {
				_parastyle = Object.extend(_parastyle, _objectStyle.__TextModeProps['paragraph']['style']);
			}
		}
		return _parastyle;
	},
	getSaveHtml: function(data) {
		return "<img src=\"" + data.imageurl + "\" class=\"txc-image\"/>";
	},
	getDispHtml: function(data) {
		return "";
	},
	getDispText: function(data) {
		return "<img src=\"" + data.fileurl + "\" class=\"txc-image\"/>";
	},
	getRegLoad: function(data) {
		return new RegExp("<(?:img|IMG)[^>]*src=\"?" + data.imageurl.getRegExp() + "\"?[^>]*\/?>", "gim");
	},
	getRegHtml: function(data) {
		return new RegExp("<(?:img|IMG)[^>]*src=\"?" + data.imageurl.getRegExp() + "\"?[^>]*\/?>", "gim");
	}, 
	getRegText: function(data) {
		return new RegExp("<(?:img|IMG)[^>]*src=\"?" + data.imageurl.getRegExp() + "\"?[^>]*\/?>", "gim");
	}
});