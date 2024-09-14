{
  actioncable = {
    dependencies = ["actionpack" "activesupport" "nio4r" "websocket-driver" "zeitwerk"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0112zkm4c2j9gj7jpqn96qdhr67hmxp6bncgmbkap46c19mwj2dl";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "7.2.1";
  };
  actionmailbox = {
    dependencies = ["actionpack" "activejob" "activerecord" "activestorage" "activesupport" "mail"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "12fz79sfd1awc5n7m58hhsskb0qx5mz9if1cs8hnb6knrc5hvhh9";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "7.2.1";
  };
  actionmailer = {
    dependencies = ["actionpack" "actionview" "activejob" "activesupport" "mail" "rails-dom-testing"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0mkfb04nx6n57cxdwl9wxs9mh1zg4l8fw06rcip0c1a1r0r3m1g4";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "7.2.1";
  };
  actionpack = {
    dependencies = ["actionview" "activesupport" "nokogiri" "racc" "rack" "rack-session" "rack-test" "rails-dom-testing" "rails-html-sanitizer" "useragent"];
    groups = ["default" "development" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1bfadpiqpz3sz8nynkid97q8qzfys826n41bxciky4i0qyn802r6";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "7.2.1";
  };
  actiontext = {
    dependencies = ["actionpack" "activerecord" "activestorage" "activesupport" "globalid" "nokogiri"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0ybxgnn11d9p3r4g8jhs6q84f0apwx36km1mzhwq063k8cwa4mqj";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "7.2.1";
  };
  actionview = {
    dependencies = ["activesupport" "builder" "erubi" "rails-dom-testing" "rails-html-sanitizer"];
    groups = ["default" "development" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1x6lmsrcdrxv9anig5hmak370gnpwisn5s56w81jm17z5ggz9y6i";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "7.2.1";
  };
  activejob = {
    dependencies = ["activesupport" "globalid"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "00y5lgkg4rf76vl81rjb5cbk65vbsprp57sfkrxz6xl2mxd5y57b";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "7.2.1";
  };
  activemodel = {
    dependencies = ["activesupport"];
    groups = ["default" "development"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0j1kcvb6slvq07kpfl6wz6cdbkzis2hhfxph4d39rf92f69f693v";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "7.2.1";
  };
  activerecord = {
    dependencies = ["activemodel" "activesupport" "timeout"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0g2krvm1w9g822w0fnsvkwl8dmr89lzl9k5gkiiz553m6fwjd2mm";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "7.2.1";
  };
  activestorage = {
    dependencies = ["actionpack" "activejob" "activerecord" "activesupport" "marcel"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0xm6jlazlgbf345rqc8d12y8jwba5dwaskr1kpzjzng5m5m79mp5";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "7.2.1";
  };
  activesupport = {
    dependencies = ["base64" "bigdecimal" "concurrent-ruby" "connection_pool" "drb" "i18n" "logger" "minitest" "securerandom" "tzinfo"];
    groups = ["default" "development" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "094cv9kxa8hwlsw3c0njkvvayd0wszcz9b6xywv4yajrg83zlmvm";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "7.2.1";
  };
  addressable = {
    dependencies = ["public_suffix"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0cl2qpvwiffym62z991ynks7imsm87qmgxf0yfsmlwzkgi9qcaa6";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "2.8.7";
  };
  ast = {
    groups = ["default" "development" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "04nc8x27hlzlrr5c2gn7mar4vdr0apw5xg22wp6m8dx3wqr04a0y";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "2.4.2";
  };
  backport = {
    groups = ["default" "development"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0xbzzjrgah0f8ifgd449kak2vyf30micpz6x2g82aipfv7ypsb4i";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "1.2.0";
  };
  base64 = {
    groups = ["default" "development" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "01qml0yilb9basf7is2614skjp8384h2pycfx86cr8023arfj98g";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.2.0";
  };
  benchmark = {
    groups = ["default" "development"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0wghmhwjzv4r9mdcny4xfz2h2cm7ci24md79rvy2x65r4i99k9sc";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.3.0";
  };
  bigdecimal = {
    groups = ["default" "development" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1gi7zqgmqwi5lizggs1jhc3zlwaqayy9rx2ah80sxy24bbnng558";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "3.1.8";
  };
  bindex = {
    groups = ["default" "development"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0zmirr3m02p52bzq4xgksq4pn8j641rx5d4czk68pv9rqnfwq7kv";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.8.1";
  };
  bootsnap = {
    dependencies = ["msgpack"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0mdgj9yw1hmx3xh2qxyjc31y8igmxzd9h0c245ay2zkz76pl4k5c";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "1.18.4";
  };
  brakeman = {
    dependencies = ["racc"];
    groups = ["development" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "078syvjnnkbair5ffyvchxj9yd2c8215c1271kfh1gqsmaf70bl6";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "6.2.1";
  };
  builder = {
    groups = ["default" "development" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0pw3r2lyagsxkm71bf44v5b74f7l9r7di22brbyji9fwz791hya9";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "3.3.0";
  };
  byebug = {
    groups = ["default" "development" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0nx3yjf4xzdgb8jkmk2344081gqr22pgjqnmjg2q64mj5d6r9194";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "11.1.3";
  };
  coderay = {
    groups = ["default" "development" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0jvxqxzply1lwp7ysn94zjhh57vc14mcshw1ygw14ib8lhc00lyw";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "1.1.3";
  };
  concurrent-ruby = {
    groups = ["default" "development" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0chwfdq2a6kbj6xz9l6zrdfnyghnh32si82la1dnpa5h75ir5anl";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "1.3.4";
  };
  connection_pool = {
    groups = ["default" "development" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1x32mcpm2cl5492kd6lbjbaf17qsssmpx9kdyr7z1wcif2cwyh0g";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "2.4.1";
  };
  crass = {
    groups = ["default" "development" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0pfl5c0pyqaparxaqxi6s4gfl21bdldwiawrc0aknyvflli60lfw";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "1.0.6";
  };
  date = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "149jknsq999gnhy865n33fkk22s0r447k76x9pmcnnwldfv2q7wp";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "3.3.4";
  };
  diff-lcs = {
    groups = ["default" "development" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1znxccz83m4xgpd239nyqxlifdb7m8rlfayk6s259186nkgj6ci7";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "1.5.1";
  };
  docile = {
    groups = ["default" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "07pj4z3h8wk4fgdn6s62vw1lwvhj0ac0x10vfbdkr9xzk7krn5cn";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "1.4.1";
  };
  dotenv = {
    groups = ["default" "development" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0y24jabiz4cf9ni9vi4j8sab8b5phpf2mpw3981r0r94l4m6q0q8";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "3.1.2";
  };
  dotenv-rails = {
    dependencies = ["dotenv" "railties"];
    groups = ["development" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0sjxr93yv1pg0dvqsfvsc5rmqrs847nwxhlfvm1ff7fab8davlk6";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "3.1.2";
  };
  drb = {
    groups = ["default" "development" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0h5kbj9hvg5hb3c7l425zpds0vb42phvln2knab8nmazg2zp5m79";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "2.2.1";
  };
  e2mmap = {
    groups = ["default" "development"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0n8gxjb63dck3vrmsdcqqll7xs7f3wk78mw8w0gdk9wp5nx6pvj5";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.1.0";
  };
  erubi = {
    groups = ["default" "development" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0qnd6ff4az22ysnmni3730c41b979xinilahzg86bn7gv93ip9pw";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "1.13.0";
  };
  factory_bot = {
    dependencies = ["activesupport"];
    groups = ["default" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0q927lvgjqj0xaplxhicj5xv8xadx3957mank3p7g01vb6iv6x33";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "6.5.0";
  };
  factory_bot_rails = {
    dependencies = ["factory_bot" "railties"];
    groups = ["test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1j6w4rr2cb5wng9yrn2ya9k40q52m0pbz47kzw8xrwqg3jncwwza";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "6.4.3";
  };
  faraday = {
    dependencies = ["faraday-em_http" "faraday-em_synchrony" "faraday-excon" "faraday-httpclient" "faraday-multipart" "faraday-net_http" "faraday-net_http_persistent" "faraday-patron" "faraday-rack" "faraday-retry" "ruby2_keywords"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1c760q0ks4vj4wmaa7nh1dgvgqiwaw0mjr7v8cymy7i3ffgjxx90";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "1.10.3";
  };
  faraday-em_http = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "12cnqpbak4vhikrh2cdn94assh3yxza8rq2p9w2j34bqg5q4qgbs";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "1.0.0";
  };
  faraday-em_synchrony = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1vgrbhkp83sngv6k4mii9f2s9v5lmp693hylfxp2ssfc60fas3a6";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "1.0.0";
  };
  faraday-excon = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0h09wkb0k0bhm6dqsd47ac601qiaah8qdzjh8gvxfd376x1chmdh";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "1.1.0";
  };
  faraday-httpclient = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0fyk0jd3ks7fdn8nv3spnwjpzx2lmxmg2gh4inz3by1zjzqg33sc";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "1.0.1";
  };
  faraday-multipart = {
    dependencies = ["multipart-post"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "09871c4hd7s5ws1wl4gs7js1k2wlby6v947m2bbzg43pnld044lh";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "1.0.4";
  };
  faraday-net_http = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "10n6wikd442mfm15hd6gzm0qb527161w1wwch4h5m4iclkz2x6b3";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "1.0.2";
  };
  faraday-net_http_persistent = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0dc36ih95qw3rlccffcb0vgxjhmipsvxhn6cw71l7ffs0f7vq30b";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "1.2.0";
  };
  faraday-patron = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "19wgsgfq0xkski1g7m96snv39la3zxz6x7nbdgiwhg5v82rxfb6w";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "1.0.0";
  };
  faraday-rack = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1h184g4vqql5jv9s9im6igy00jp6mrah2h14py6mpf9bkabfqq7g";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "1.0.0";
  };
  faraday-retry = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "153i967yrwnswqgvnnajgwp981k9p50ys1h80yz3q94rygs59ldd";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "1.0.3";
  };
  faraday_middleware = {
    dependencies = ["faraday"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1bw8mfh4yin2xk7138rg3fhb2p5g2dlmdma88k82psah9mbmvlfy";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "1.2.0";
  };
  ffi = {
    groups = ["default" "development" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "07139870npj59jnl8vmk39ja3gdk3fb5z9vc0lf32y2h891hwqsi";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "1.17.0";
  };
  foreman = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "02m0iq43hrb99hca9ng834sx2p8zfc5xga1xwqn8lckabc925h2r";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.88.1";
  };
  globalid = {
    dependencies = ["activesupport"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1sbw6b66r7cwdx3jhs46s4lr991969hvigkjpbdl7y3i31qpdgvh";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "1.2.1";
  };
  google-protobuf = {
    dependencies = ["bigdecimal" "rake"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0nbla8v0ahxjcvlslxrgp3w9n5s5gqqjij7m1jz8m407yih3z78z";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "4.28.1";
  };
  googleapis-common-protos-types = {
    dependencies = ["google-protobuf"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1xyinc2zaw25r3x774mni66im1b22l9zpbsqdgdb4g4zxcd5srcl";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "1.16.0";
  };
  govspeak = {
    dependencies = ["actionview" "addressable" "govuk_publishing_components" "htmlentities" "i18n" "kramdown" "nokogiri" "rinku" "sanitize"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0f1v9ialkha26magkzsljxsd5jyfpf32p3i1yp4ip91kb31lgk01";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "8.3.4";
  };
  govuk_app_config = {
    dependencies = ["logstasher" "opentelemetry-exporter-otlp" "opentelemetry-instrumentation-all" "opentelemetry-sdk" "plek" "prometheus_exporter" "puma" "rack-proxy" "sentry-rails" "sentry-ruby" "statsd-ruby"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "14l70nc2nkh5db5zlm8zhi9vny5c2b92adn0zxfmi0kmnwjw2glq";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "9.14.0";
  };
  govuk_design_system_formbuilder = {
    dependencies = ["actionview" "activemodel" "activesupport" "html-attributes-utils"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0x6sbh5ssfla4zzaypjrkli226z3ha0267xs2zf6ymsjf40jr6zm";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "5.6.0";
  };
  govuk_personalisation = {
    dependencies = ["plek" "rails"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "07srzkgxscs5sc7s8cgf41q2f5qn0m307faw58mandfy4q735vvi";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "1.0.0";
  };
  govuk_publishing_components = {
    dependencies = ["govuk_app_config" "govuk_personalisation" "kramdown" "plek" "rails" "rouge" "sprockets" "sprockets-rails"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1szv4j7iqjrk043icapk6aav7a01lvdgp19vdylvb5mcps5bc796";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "43.1.1";
  };
  html-attributes-utils = {
    dependencies = ["activesupport"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "132kwasf3rn29x9zw27xfmk8fvw936bywfw9pr55aknxncvhnkjr";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "1.0.2";
  };
  htmlentities = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1nkklqsn8ir8wizzlakncfv42i32wc0w9hxp00hvdlgjr7376nhj";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "4.3.4";
  };
  i18n = {
    dependencies = ["concurrent-ruby"];
    groups = ["default" "development" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1ffix518y7976qih9k1lgnc17i3v6yrlh0a3mckpxdb4wc2vrp16";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "1.14.5";
  };
  io-console = {
    groups = ["default" "development" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "08d2lx42pa8jjav0lcjbzfzmw61b8imxr9041pva8xzqabrczp7h";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.7.2";
  };
  irb = {
    dependencies = ["rdoc" "reline"];
    groups = ["default" "development" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "05g6vpz3997q4j3xhrliswfx3g5flsn5cfn1p1s4h6dx7c0hbn2k";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "1.14.0";
  };
  jaro_winkler = {
    groups = ["default" "development"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "09645h5an19zc1i7wlmixszj8xxqb2zc8qlf8dmx39bxpas1l24b";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "1.6.0";
  };
  json = {
    groups = ["default" "development" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0b4qsi8gay7ncmigr0pnbxyb17y3h8kavdyhsh7nrlqwr35vb60q";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "2.7.2";
  };
  kramdown = {
    dependencies = ["rexml"];
    groups = ["default" "development"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1ic14hdcqxn821dvzki99zhmcy130yhv5fqfffkcf87asv5mnbmn";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "2.4.0";
  };
  kramdown-parser-gfm = {
    dependencies = ["kramdown"];
    groups = ["default" "development"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0a8pb3v951f4x7h968rqfsa19c8arz21zw1vaj42jza22rap8fgv";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "1.1.0";
  };
  language_server-protocol = {
    groups = ["default" "development" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0gvb1j8xsqxms9mww01rmdl78zkd72zgxaap56bhv8j45z05hp1x";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "3.17.0.3";
  };
  listen = {
    dependencies = ["rb-fsevent" "rb-inotify"];
    groups = ["development"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0rwwsmvq79qwzl6324yc53py02kbrcww35si720490z5w0j497nv";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "3.9.0";
  };
  logger = {
    groups = ["default" "development" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0lwncq2rf8gm79g2rcnnyzs26ma1f4wnfjm6gs4zf2wlsdz5in9s";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "1.6.1";
  };
  lograge = {
    dependencies = ["actionpack" "activesupport" "railties" "request_store"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1qcsvh9k4c0cp6agqm9a8m4x2gg7vifryqr7yxkg2x9ph9silds2";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.14.0";
  };
  logstash-event = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1bk7fhhryjxp1klr3hq6i6srrc21wl4p980bysjp0w66z9hdr9w9";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "1.2.02";
  };
  logstasher = {
    dependencies = ["activesupport" "request_store"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "00hdrmyn2a0j0yzsqcz92w2wfxiprx3kk6wh46jrsax7v4494ph9";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "2.1.5";
  };
  loofah = {
    dependencies = ["crass" "nokogiri"];
    groups = ["default" "development" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1zkjqf37v2d7s11176cb35cl83wls5gm3adnfkn2zcc61h3nxmqh";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "2.22.0";
  };
  mail = {
    dependencies = ["mini_mime" "net-imap" "net-pop" "net-smtp"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1bf9pysw1jfgynv692hhaycfxa8ckay1gjw5hz3madrbrynryfzc";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "2.8.1";
  };
  marcel = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "190n2mk8m1l708kr88fh6mip9sdsh339d2s6sgrik3sbnvz4jmhd";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "1.0.4";
  };
  method_source = {
    groups = ["default" "development" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1igmc3sq9ay90f8xjvfnswd1dybj1s3fi0dwd53inwsvqk4h24qq";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "1.1.0";
  };
  mini_mime = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1vycif7pjzkr29mfk4dlqv3disc5dn0va04lkwajlpr1wkibg0c6";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "1.1.5";
  };
  mini_portile2 = {
    groups = ["default" "development" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1q1f2sdw3y3y9mnym9dhjgsjr72sq975cfg5c4yx7gwv8nmzbvhk";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "2.8.7";
  };
  minitest = {
    groups = ["default" "development" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1n1akmc6bibkbxkzm1p1wmfb4n9vv397knkgz0ffykb3h1d7kdix";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "5.25.1";
  };
  msgpack = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1a5adcb7bwan09mqhj3wi9ib52hmdzmqg7q08pggn3adibyn5asr";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "1.7.2";
  };
  multipart-post = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0lgyysrpl50wgcb9ahg29i4p01z0irb3p9lirygma0kkfr5dgk9x";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "2.3.0";
  };
  net-http-persistent = {
    dependencies = ["connection_pool"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1cpllwpxlqs395cxcbx2rprgjp75x9z6hzvysrf0z2bjix97waxn";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "4.0.4";
  };
  net-imap = {
    dependencies = ["date" "net-protocol"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0hrjsi3a7r4vzkjpk5p0sri1frlprhr2ck1vzpi30bh4dy909qbh";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.4.16";
  };
  net-pop = {
    dependencies = ["net-protocol"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1wyz41jd4zpjn0v1xsf9j778qx1vfrl24yc20cpmph8k42c4x2w4";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.1.2";
  };
  net-protocol = {
    dependencies = ["timeout"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1a32l4x73hz200cm587bc29q8q9az278syw3x6fkc9d1lv5y0wxa";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.2.2";
  };
  net-smtp = {
    dependencies = ["net-protocol"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0amlhz8fhnjfmsiqcjajip57ici2xhw089x7zqyhpk51drg43h2z";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.5.0";
  };
  nio4r = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "017nbw87dpr4wyk81cgj8kxkxqgsgblrkxnmmadc77cg9gflrfal";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "2.7.3";
  };
  nokogiri = {
    dependencies = ["mini_portile2" "racc"];
    groups = ["default" "development" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "15gysw8rassqgdq3kwgl4mhqmrgh7nk2qvrcqp4ijyqazgywn6gq";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "1.16.7";
  };
  opentelemetry-api = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0dj0cqxz0fl2934pmq4pvnb4wpapjfcsjnzb8vll08bcspjdwcx7";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "1.4.0";
  };
  opentelemetry-common = {
    dependencies = ["opentelemetry-api"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "160ws06d8mzx3hwjss2i954h8r86dp3sw95k2wrbq81sb121m2gy";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.21.0";
  };
  opentelemetry-exporter-otlp = {
    dependencies = ["google-protobuf" "googleapis-common-protos-types" "opentelemetry-api" "opentelemetry-common" "opentelemetry-sdk" "opentelemetry-semantic_conventions"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0saiiaf5bkg95fjcq6asz5w86s6zg76xb0r93dcffhvnz36z0r2v";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.28.1";
  };
  opentelemetry-helpers-mysql = {
    dependencies = ["opentelemetry-api" "opentelemetry-common"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1nni39rjqnr29p2zg31g9wyz30kg4vncsp4hf7q87r671fwxm6fd";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.1.1";
  };
  opentelemetry-helpers-sql-obfuscation = {
    dependencies = ["opentelemetry-common"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0v44n3lgkclnfjg9iz5jaay7fkcqvb35jrkm2b68fr2cyy778mnz";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.2.0";
  };
  opentelemetry-instrumentation-action_mailer = {
    dependencies = ["opentelemetry-api" "opentelemetry-instrumentation-active_support" "opentelemetry-instrumentation-base"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1afibmwprdiqnkin7lb6zdxng36rqa7qbl5fl9wx0lchpc039zjj";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.1.0";
  };
  opentelemetry-instrumentation-action_pack = {
    dependencies = ["opentelemetry-api" "opentelemetry-instrumentation-base" "opentelemetry-instrumentation-rack"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "16nbkayp8jb2zkqj2rmqd4d1mz4wdf0zg6jx8b0vzkf9mxr89py5";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.9.0";
  };
  opentelemetry-instrumentation-action_view = {
    dependencies = ["opentelemetry-api" "opentelemetry-instrumentation-active_support" "opentelemetry-instrumentation-base"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "08ga079lc2xariw83xc4ly1kab718ripmfb9af7xh6vm9qajka3d";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.7.3";
  };
  opentelemetry-instrumentation-active_job = {
    dependencies = ["opentelemetry-api" "opentelemetry-instrumentation-base"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1a5afx39bf0pzi0w75ic8zs8447i96993h056ww4vr23zl585f2x";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.7.7";
  };
  opentelemetry-instrumentation-active_model_serializers = {
    dependencies = ["opentelemetry-api" "opentelemetry-instrumentation-base"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0yw98f8z6k4c8ns7p8ik2dc68p4vbi12xnavzw0vqhlnny4nx0n7";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.20.2";
  };
  opentelemetry-instrumentation-active_record = {
    dependencies = ["opentelemetry-api" "opentelemetry-instrumentation-base"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1fq0i6rmxvgj56jafj8ka19j2nkpj2yvj7h0zi0hc4s6r1s2xmvx";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.7.4";
  };
  opentelemetry-instrumentation-active_support = {
    dependencies = ["opentelemetry-api" "opentelemetry-instrumentation-base"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1q07nn9ipq2yd7xjj24hh00cbvlda269k1l0xfkc8d8iw8mixrsg";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.6.0";
  };
  opentelemetry-instrumentation-all = {
    dependencies = ["opentelemetry-instrumentation-active_model_serializers" "opentelemetry-instrumentation-aws_lambda" "opentelemetry-instrumentation-aws_sdk" "opentelemetry-instrumentation-bunny" "opentelemetry-instrumentation-concurrent_ruby" "opentelemetry-instrumentation-dalli" "opentelemetry-instrumentation-delayed_job" "opentelemetry-instrumentation-ethon" "opentelemetry-instrumentation-excon" "opentelemetry-instrumentation-faraday" "opentelemetry-instrumentation-grape" "opentelemetry-instrumentation-graphql" "opentelemetry-instrumentation-gruf" "opentelemetry-instrumentation-http" "opentelemetry-instrumentation-http_client" "opentelemetry-instrumentation-koala" "opentelemetry-instrumentation-lmdb" "opentelemetry-instrumentation-mongo" "opentelemetry-instrumentation-mysql2" "opentelemetry-instrumentation-net_http" "opentelemetry-instrumentation-pg" "opentelemetry-instrumentation-que" "opentelemetry-instrumentation-racecar" "opentelemetry-instrumentation-rack" "opentelemetry-instrumentation-rails" "opentelemetry-instrumentation-rake" "opentelemetry-instrumentation-rdkafka" "opentelemetry-instrumentation-redis" "opentelemetry-instrumentation-resque" "opentelemetry-instrumentation-restclient" "opentelemetry-instrumentation-ruby_kafka" "opentelemetry-instrumentation-sidekiq" "opentelemetry-instrumentation-sinatra" "opentelemetry-instrumentation-trilogy"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1svld9vc7ykb4fgimgkdb6cnmcrxiymjl3h4l49d3ll53vc91ygl";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.62.1";
  };
  opentelemetry-instrumentation-aws_lambda = {
    dependencies = ["opentelemetry-api" "opentelemetry-instrumentation-base"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0rrw5s2nl5pkrx05p96jgqn5zqwwczyin3b3mmd07rs64w1bkpl9";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.1.1";
  };
  opentelemetry-instrumentation-aws_sdk = {
    dependencies = ["opentelemetry-api" "opentelemetry-instrumentation-base"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1fxk5jaliz93njgfmbl5ygsbzbwqbh0g48w4ar905xxsfg1dl18q";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.5.4";
  };
  opentelemetry-instrumentation-base = {
    dependencies = ["opentelemetry-api" "opentelemetry-common" "opentelemetry-registry"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0psjpqigi7k0fky1kd54jzf9r779vh2c86ngjppn7ifmnh4n3r9y";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.22.6";
  };
  opentelemetry-instrumentation-bunny = {
    dependencies = ["opentelemetry-api" "opentelemetry-instrumentation-base"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1ajvsri8qr98ln0jiz51amdfxwayn2m63qcpxi79pbjc0gilivl6";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.21.4";
  };
  opentelemetry-instrumentation-concurrent_ruby = {
    dependencies = ["opentelemetry-api" "opentelemetry-instrumentation-base"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1khlhzwb37mqnzr1vr49ljhi4bplmq9w8ndm0k8xbfsr8h8wivq4";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.21.4";
  };
  opentelemetry-instrumentation-dalli = {
    dependencies = ["opentelemetry-api" "opentelemetry-instrumentation-base"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "15q65w7apq5lp9x86slypaikrssp7vq5y629znirxvkw14wp9c47";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.25.4";
  };
  opentelemetry-instrumentation-delayed_job = {
    dependencies = ["opentelemetry-api" "opentelemetry-instrumentation-base"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0vrbi9nk09axp8j66f4vb2hmvn8kbip7bl6lrmvznq44dvnj1m8w";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.22.4";
  };
  opentelemetry-instrumentation-ethon = {
    dependencies = ["opentelemetry-api" "opentelemetry-instrumentation-base"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1s6ya4sr4w492qbd16b33qpk52wf3903l2ns6camv79kq1h7vahr";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.21.8";
  };
  opentelemetry-instrumentation-excon = {
    dependencies = ["opentelemetry-api" "opentelemetry-instrumentation-base"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "14g6dvk31kz9v9qbr2w6ggxk96v3kaadm8wvnw3qsrsc4pd9ycns";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.22.4";
  };
  opentelemetry-instrumentation-faraday = {
    dependencies = ["opentelemetry-api" "opentelemetry-instrumentation-base"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0np6wnckn12df6mwcr695fvjy3x2s6541ywr7ahw8a8dszs0qjsh";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.24.6";
  };
  opentelemetry-instrumentation-grape = {
    dependencies = ["opentelemetry-api" "opentelemetry-instrumentation-base" "opentelemetry-instrumentation-rack"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1dhpapza8qw8clfp7pri6r6sbibrx07sj7xfk3myivmp05rms8m1";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.2.0";
  };
  opentelemetry-instrumentation-graphql = {
    dependencies = ["opentelemetry-api" "opentelemetry-instrumentation-base"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0v6w0b3q0li5cq0xmc42ngqk9ahx60n5q31alka36ds4inxcrky2";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.28.4";
  };
  opentelemetry-instrumentation-gruf = {
    dependencies = ["opentelemetry-api" "opentelemetry-instrumentation-base"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0if57lll1f29pl56s8qbm159f97b7mhrcbjka5r7wq080lv1h2sf";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.2.1";
  };
  opentelemetry-instrumentation-http = {
    dependencies = ["opentelemetry-api" "opentelemetry-instrumentation-base"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "05mrlg8msp59bagpc18ycr9333760kqp780gw8fgqn1798dl02qr";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.23.4";
  };
  opentelemetry-instrumentation-http_client = {
    dependencies = ["opentelemetry-api" "opentelemetry-instrumentation-base"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0g6f5zv0bq585ppgzhm6acrpkz32j1h7zyrcy1r8n3ha41daip1z";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.22.7";
  };
  opentelemetry-instrumentation-koala = {
    dependencies = ["opentelemetry-api" "opentelemetry-instrumentation-base"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1i1vpy7h5gq9c5rs5ann2i5h5m18y9pzvdxjmpzd575y34d92kdl";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.20.5";
  };
  opentelemetry-instrumentation-lmdb = {
    dependencies = ["opentelemetry-api" "opentelemetry-instrumentation-base"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "00m5ml5ixv1g8gmpqcqsrw8c72mf70rfbrd8cjdaq9bhdwan0v9p";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.22.3";
  };
  opentelemetry-instrumentation-mongo = {
    dependencies = ["opentelemetry-api" "opentelemetry-instrumentation-base"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1lcrsrjszj908qpl22p3r6bpl69xajyfcasgygr8b75lx1hfdakp";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.22.4";
  };
  opentelemetry-instrumentation-mysql2 = {
    dependencies = ["opentelemetry-api" "opentelemetry-helpers-mysql" "opentelemetry-helpers-sql-obfuscation" "opentelemetry-instrumentation-base"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1sggbiwdycq9911lgvd6wfklkn204ppjyfcn4xqb64sxbqxqdmv6";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.27.2";
  };
  opentelemetry-instrumentation-net_http = {
    dependencies = ["opentelemetry-api" "opentelemetry-instrumentation-base"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1l26f8sqsjjcc72a5xr9as3gibm4sgj8n004y15i5vbvdgzjfx60";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.22.7";
  };
  opentelemetry-instrumentation-pg = {
    dependencies = ["opentelemetry-api" "opentelemetry-helpers-sql-obfuscation" "opentelemetry-instrumentation-base"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1zxx75rd2fv82rzc7nw03x5ba7pmbnw32jns566n6wqvzsn3x2cr";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.27.4";
  };
  opentelemetry-instrumentation-que = {
    dependencies = ["opentelemetry-api" "opentelemetry-instrumentation-base"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0yn022g9dziz5cwdvys7n4s9bmn5q9v6aygbv0wymxlxvh8c4f7s";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.8.3";
  };
  opentelemetry-instrumentation-racecar = {
    dependencies = ["opentelemetry-api" "opentelemetry-instrumentation-base"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0qz159bjzlmygga8gpngk7zdq08a5fmn8zwhjh1wz1w4vcrzy1f6";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.3.4";
  };
  opentelemetry-instrumentation-rack = {
    dependencies = ["opentelemetry-api" "opentelemetry-instrumentation-base"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1dmfxcc2xz2qa4zp0sks5zrqcfr4fbpbc9xdgvcv8ys0ipf7pwn0";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.24.6";
  };
  opentelemetry-instrumentation-rails = {
    dependencies = ["opentelemetry-api" "opentelemetry-instrumentation-action_mailer" "opentelemetry-instrumentation-action_pack" "opentelemetry-instrumentation-action_view" "opentelemetry-instrumentation-active_job" "opentelemetry-instrumentation-active_record" "opentelemetry-instrumentation-active_support" "opentelemetry-instrumentation-base"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "12k4s1k9wa257bqfny33byscb4ai86jw4q6ygrzsj3iv2bij07w9";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.31.2";
  };
  opentelemetry-instrumentation-rake = {
    dependencies = ["opentelemetry-api" "opentelemetry-instrumentation-base"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0840gnlr90nbl430yc72czn26bngdp94v4adz7q9ph3pmdm8mppv";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.2.2";
  };
  opentelemetry-instrumentation-rdkafka = {
    dependencies = ["opentelemetry-api" "opentelemetry-instrumentation-base"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1pmx5kz9cz7x8i8f45jivibndqxip542p7ik764pb3ylwraky4n6";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.4.8";
  };
  opentelemetry-instrumentation-redis = {
    dependencies = ["opentelemetry-api" "opentelemetry-instrumentation-base"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1qrgnk2x64sks9gqb7fycfa6sass6ddqzh5dms4hdbz1bzag581f";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.25.7";
  };
  opentelemetry-instrumentation-resque = {
    dependencies = ["opentelemetry-api" "opentelemetry-instrumentation-base"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "04d03zvmm3d9h6qvwdpy34lrywzphhs7fc2xgmad5zs847zb0jvy";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.5.2";
  };
  opentelemetry-instrumentation-restclient = {
    dependencies = ["opentelemetry-api" "opentelemetry-instrumentation-base"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0h99imc6s2rnpmkx2zghidbp6ggmz85wpicldmwph7y88pq29v8l";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.22.7";
  };
  opentelemetry-instrumentation-ruby_kafka = {
    dependencies = ["opentelemetry-api" "opentelemetry-instrumentation-base"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1mh7nf99k7hnyaizw4bs8g25sj984d4vjsb3dp81ymf8fb07m5fd";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.21.3";
  };
  opentelemetry-instrumentation-sidekiq = {
    dependencies = ["opentelemetry-api" "opentelemetry-instrumentation-base"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0cfzw1avv52idxvq02y95g3byxsswccck78zch5hmnnzvp5f59nn";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.25.7";
  };
  opentelemetry-instrumentation-sinatra = {
    dependencies = ["opentelemetry-api" "opentelemetry-instrumentation-base" "opentelemetry-instrumentation-rack"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0fvzxr49fpqdfmv7xalivziji1jdggyqq5fw773pqn01svlkb8qn";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.24.1";
  };
  opentelemetry-instrumentation-trilogy = {
    dependencies = ["opentelemetry-api" "opentelemetry-helpers-mysql" "opentelemetry-helpers-sql-obfuscation" "opentelemetry-instrumentation-base" "opentelemetry-semantic_conventions"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0lqkkn57b3bq518q5k3nvc4kplgkjcb2jw3r6kb22gisi3x5s8k7";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.59.3";
  };
  opentelemetry-registry = {
    dependencies = ["opentelemetry-api"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1pw87n9vpv40hf7f6gyl2vvbl11hzdkv4psbbv3x23jvccs8593k";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.3.1";
  };
  opentelemetry-sdk = {
    dependencies = ["opentelemetry-api" "opentelemetry-common" "opentelemetry-registry" "opentelemetry-semantic_conventions"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0div7n5wac7x1l9fwdpb3bllw18cns93c7xccy27r4gmvv02f46s";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "1.5.0";
  };
  opentelemetry-semantic_conventions = {
    dependencies = ["opentelemetry-api"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "10anxw736pg85nw8vb11xnr5faq7qj8a1d8c62qbpjs6m0izi77y";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "1.10.1";
  };
  parallel = {
    groups = ["default" "development" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1vy7sjs2pgz4i96v5yk9b7aafbffnvq7nn419fgvw55qlavsnsyq";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "1.26.3";
  };
  parser = {
    dependencies = ["ast" "racc"];
    groups = ["default" "development" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1cqs31cyg2zp8yx2zzm3zkih0j93q870wasbviy2w343nxqvn3pk";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "3.3.5.0";
  };
  plek = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "03idxmrzpqdwvbqxv8272i4y35qma5l4s2620f4w71y6nyykb7vw";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "5.2.0";
  };
  prometheus_exporter = {
    dependencies = ["webrick"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "06ydq9d09w8m1vk6jp0gy7ab03nvlcf28hi07arpq6x5cxd2aljk";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "2.1.1";
  };
  pry = {
    dependencies = ["coderay" "method_source"];
    groups = ["default" "development" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0k9kqkd9nps1w1r1rb7wjr31hqzkka2bhi8b518x78dcxppm9zn4";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.14.2";
  };
  pry-byebug = {
    dependencies = ["byebug" "pry"];
    groups = ["development" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1y41al94ks07166qbp2200yzyr5y60hm7xaiw4lxpgsm4b1pbyf8";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "3.10.1";
  };
  pry-rails = {
    dependencies = ["pry"];
    groups = ["development" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0garafb0lxbm3sx2r9pqgs7ky9al58cl3wmwc0gmvmrl9bi2i7m6";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.3.11";
  };
  psych = {
    dependencies = ["stringio"];
    groups = ["default" "development" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0s5383m6004q76xm3lb732bp4sjzb6mxb6rbgn129gy2izsj4wrk";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "5.1.2";
  };
  public_suffix = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0vqcw3iwby3yc6avs1vb3gfd0vcp2v7q310665dvxfswmcf4xm31";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "6.0.1";
  };
  puma = {
    dependencies = ["nio4r"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0i2vaww6qcazj0ywva1plmjnj6rk23b01szswc5jhcq7s2cikd1y";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "6.4.2";
  };
  racc = {
    groups = ["default" "development" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0byn0c9nkahsl93y9ln5bysq4j31q8xkf2ws42swighxd4lnjzsa";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "1.8.1";
  };
  rack = {
    groups = ["default" "development" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "12z55b90vvr4sh93az2yfr3fg91jivsag8lcg0k360d99vdq568f";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "3.1.7";
  };
  rack-proxy = {
    dependencies = ["rack"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "12jw7401j543fj8cc83lmw72d8k6bxvkp9rvbifi88hh01blnsj4";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.7.7";
  };
  rack-session = {
    dependencies = ["rack"];
    groups = ["default" "development" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "10afdpmy9kh0qva96slcyc59j4gkk9av8ilh58cnj0qq7q3b416v";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "2.0.0";
  };
  rack-test = {
    dependencies = ["rack"];
    groups = ["default" "development" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1ysx29gk9k14a14zsp5a8czys140wacvp91fja8xcja0j1hzqq8c";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "2.1.0";
  };
  rackup = {
    dependencies = ["rack" "webrick"];
    groups = ["default" "development" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0kbcka30g681cqasw47pq93fxjscq7yvs5zf8lp3740rb158ijvf";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "2.1.0";
  };
  rails = {
    dependencies = ["actioncable" "actionmailbox" "actionmailer" "actionpack" "actiontext" "actionview" "activejob" "activemodel" "activerecord" "activestorage" "activesupport" "railties"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "01dp24cmzs981ss8rn30gz6wilbwllqqnfkacrh0j8h7s3jq8mpx";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "7.2.1";
  };
  rails-controller-testing = {
    dependencies = ["actionpack" "actionview" "activesupport"];
    groups = ["development" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "151f303jcvs8s149mhx2g5mn67487x0blrf9dzl76q1nb7dlh53l";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "1.0.5";
  };
  rails-dom-testing = {
    dependencies = ["activesupport" "minitest" "nokogiri"];
    groups = ["default" "development" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0fx9dx1ag0s1lr6lfr34lbx5i1bvn3bhyf3w3mx6h7yz90p725g5";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "2.2.0";
  };
  rails-html-sanitizer = {
    dependencies = ["loofah" "nokogiri"];
    groups = ["default" "development" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1pm4z853nyz1bhhqr7fzl44alnx4bjachcr6rh6qjj375sfz3sc6";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "1.6.0";
  };
  railties = {
    dependencies = ["actionpack" "activesupport" "irb" "rackup" "rake" "thor" "zeitwerk"];
    groups = ["default" "development" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0qw4ainigv7w07c5gfbrw484jpcg59bdzj7vwzbji4pvpdwx4sjb";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "7.2.1";
  };
  rainbow = {
    groups = ["default" "development" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0smwg4mii0fm38pyb5fddbmrdpifwv22zv3d3px2xx497am93503";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "3.1.1";
  };
  rake = {
    groups = ["default" "development" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "17850wcwkgi30p7yqh60960ypn7yibacjjha0av78zaxwvd3ijs6";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "13.2.1";
  };
  rb-fsevent = {
    groups = ["default" "development" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1zmf31rnpm8553lqwibvv3kkx0v7majm1f341xbxc0bk5sbhp423";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.11.2";
  };
  rb-inotify = {
    dependencies = ["ffi"];
    groups = ["default" "development" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0vmy8xgahixcz6hzwy4zdcyn2y6d6ri8dqv5xccgzc1r292019x0";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.11.1";
  };
  rbs = {
    groups = ["default" "development"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0dgj5n7rj83981fvrhswfwsh88x42p7r00nvd80hkxmdcjvda2h6";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "2.8.4";
  };
  rdoc = {
    dependencies = ["psych"];
    groups = ["default" "development" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0ygk2zk0ky3d88v3ll7qh6xqvbvw5jin0hqdi1xkv1dhaw7myzdi";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "6.7.0";
  };
  regexp_parser = {
    groups = ["default" "development" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0ik40vcv7mqigsfpqpca36hpmnx0536xa825ai5qlkv3mmkyf9ss";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "2.9.2";
  };
  reline = {
    dependencies = ["io-console"];
    groups = ["default" "development" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0rl1jmxs7pay58l7lkxkrn6nkdpk52k8rvnfwqsd1swjlxlwjq0n";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.5.10";
  };
  request_store = {
    dependencies = ["rack"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1jw89j9s5p5cq2k7ffj5p4av4j4fxwvwjs1a4i9g85d38r9mvdz1";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "1.7.0";
  };
  reverse_markdown = {
    dependencies = ["nokogiri"];
    groups = ["default" "development"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0087vhw5ik50lxvddicns01clkx800fk5v5qnrvi3b42nrk6885j";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "2.1.1";
  };
  rexml = {
    groups = ["default" "development" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "09shc1dvg88c4yx83d4c9wf26z838nlapa3cmlq8iqdci39a98v2";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "3.3.7";
  };
  rinku = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0zcdha17s1wzxyc5814j6319wqg33jbn58pg6wmxpws36476fq4b";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "2.0.6";
  };
  rouge = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "072qvvrcqj0yfr3b0j932mlhvn41i38bq37z7z07i3ikagndkqwy";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "4.3.0";
  };
  rspec-core = {
    dependencies = ["rspec-support"];
    groups = ["default" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0s688wfw77fjldzayvczg8bgwcgh6bh552dw7qcj1rhjk3r4zalx";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "3.13.1";
  };
  rspec-expectations = {
    dependencies = ["diff-lcs" "rspec-support"];
    groups = ["default" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0n3cyrhsa75x5wwvskrrqk56jbjgdi2q1zx0irllf0chkgsmlsqf";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "3.13.3";
  };
  rspec-mocks = {
    dependencies = ["diff-lcs" "rspec-support"];
    groups = ["default" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0f3vgp43hajw716vmgjv6f4ar6f97zf50snny6y3fy9kkj4qjw88";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "3.13.1";
  };
  rspec-rails = {
    dependencies = ["actionpack" "activesupport" "railties" "rspec-core" "rspec-expectations" "rspec-mocks" "rspec-support"];
    groups = ["test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1ycjggcmzbgrfjk04v26b43c3fj5jq2qic911qk7585wvav2qaxd";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "7.0.1";
  };
  rspec-support = {
    groups = ["default" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "03z7gpqz5xkw9rf53835pa8a9vgj4lic54rnix9vfwmp2m7pv1s8";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "3.13.1";
  };
  rspec_junit_formatter = {
    dependencies = ["rspec-core"];
    groups = ["test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "059bnq1gcwl9g93cqf13zpz38zk7jxaa43anzz06qkmfwrsfdpa0";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.6.0";
  };
  rubocop = {
    dependencies = ["json" "language_server-protocol" "parallel" "parser" "rainbow" "regexp_parser" "rexml" "rubocop-ast" "ruby-progressbar" "unicode-display_width"];
    groups = ["default" "development" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0fqzc4pr1cbdycfx16gbkkfhxzz5a7kn04043h5407kpcccbyi9i";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "1.64.1";
  };
  rubocop-ast = {
    dependencies = ["parser"];
    groups = ["default" "development" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "063qgvqbyv354icl2sgx758z22wzq38hd9skc3n96sbpv0cdc1qv";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "1.31.3";
  };
  rubocop-capybara = {
    dependencies = ["rubocop"];
    groups = ["default" "development" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1aw0n8jwhsr39r9q2k90xjmcz8ai2k7xx2a87ld0iixnv3ylw9jx";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "2.21.0";
  };
  rubocop-govuk = {
    dependencies = ["rubocop" "rubocop-ast" "rubocop-capybara" "rubocop-rails" "rubocop-rake" "rubocop-rspec"];
    groups = ["development" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1jw1jh6jrl42x2qydvyn1g1dbjpgkyy5276167mxbz3hj45gzj2g";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "5.0.2";
  };
  rubocop-rails = {
    dependencies = ["activesupport" "rack" "rubocop" "rubocop-ast"];
    groups = ["default" "development" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "19g6m8ladix1dq8darrqnhbj6n3cgp2ivxnh48yj3nrgw0z97229";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "2.25.1";
  };
  rubocop-rake = {
    dependencies = ["rubocop"];
    groups = ["default" "development" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1nyq07sfb3vf3ykc6j2d5yq824lzq1asb474yka36jxgi4hz5djn";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.6.0";
  };
  rubocop-rspec = {
    dependencies = ["rubocop"];
    groups = ["default" "development" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1q797zdwscbdx6gm1ip9zbx1l985xm44riz6mmk2lglsxdbfqnsm";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "3.0.1";
  };
  ruby-progressbar = {
    groups = ["default" "development" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0cwvyb7j47m7wihpfaq7rc47zwwx9k4v7iqd9s1xch5nm53rrz40";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "1.13.0";
  };
  ruby2_keywords = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1vz322p8n39hz3b4a9gkmz9y7a5jaz41zrm2ywf31dvkqm03glgz";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.0.5";
  };
  sanitize = {
    dependencies = ["crass" "nokogiri"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0lj1jjxn1znxmaf6jnngfrz26rw85smxb69m4jl6a9yq6gwyab54";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "6.1.3";
  };
  sass = {
    dependencies = ["sass-listen"];
    groups = ["default" "development" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0p95lhs0jza5l7hqci1isflxakz83xkj97lkvxl919is0lwhv2w0";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "3.7.4";
  };
  sass-listen = {
    dependencies = ["rb-fsevent" "rb-inotify"];
    groups = ["default" "development" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0xw3q46cmahkgyldid5hwyiwacp590zj2vmswlll68ryvmvcp7df";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "4.0.0";
  };
  scss_lint = {
    dependencies = ["sass"];
    groups = ["default" "development" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0nrpgwvpmyxzlw0c580kd4dhfqp5185ckdc32nw83kfxrphx1lma";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.60.0";
  };
  scss_lint-govuk = {
    dependencies = ["scss_lint"];
    groups = ["development" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1zmw1y301m3fgkwaz31xs19xng8lplr8v3y08j9iziaw4hsrcw3v";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.2.0";
  };
  securerandom = {
    groups = ["default" "development" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1phv6kh417vkanhssbjr960c0gfqvf8z7d3d9fd2yvd41q64bw4q";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.3.1";
  };
  semantic_range = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1dlp97vg95plrsaaqj7x8l7z9vsjbhnqk4rw1l30gy26lmxpfrih";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "3.0.0";
  };
  sentry-rails = {
    dependencies = ["railties" "sentry-ruby"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "158rhsv547f3c31kfz8kdr7kpgm34sqm0bzbkxpqg3pazqim7bfl";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "5.19.0";
  };
  sentry-ruby = {
    dependencies = ["bigdecimal" "concurrent-ruby"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "12w3w779dcab85x1i4aavd5fw8xdb7mvhs3cvx85q2l48vr8kpqd";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "5.19.0";
  };
  shoulda-matchers = {
    dependencies = ["activesupport"];
    groups = ["test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1c082vpfdf3865xq6xayxw2hwqswhnc9g030p1gi4hmk9dzvnmch";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "6.4.0";
  };
  simplecov = {
    dependencies = ["docile" "simplecov-html" "simplecov_json_formatter"];
    groups = ["test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "198kcbrjxhhzca19yrdcd6jjj9sb51aaic3b0sc3pwjghg3j49py";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.22.0";
  };
  simplecov-html = {
    groups = ["default" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "02zi3rwihp7rlnp9x18c9idnkx7x68w6jmxdhyc0xrhjwrz0pasx";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.13.1";
  };
  simplecov_json_formatter = {
    groups = ["default" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0a5l0733hj7sk51j81ykfmlk2vd5vaijlq9d5fn165yyx3xii52j";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.1.4";
  };
  solargraph = {
    dependencies = ["backport" "benchmark" "diff-lcs" "e2mmap" "jaro_winkler" "kramdown" "kramdown-parser-gfm" "parser" "rbs" "reverse_markdown" "rubocop" "thor" "tilt" "yard"];
    groups = ["development"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0qbjgsrlrwvbywzi0shf3nmfhb52y5fmp9al9nk7c4qqwxyhz397";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.50.0";
  };
  spring = {
    groups = ["development"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1bm5w3mp597vy0cjwx609k3jdh5zik36ffmna7hchrn9g96s45w5";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "4.2.1";
  };
  spring-watcher-listen = {
    dependencies = ["listen" "spring"];
    groups = ["development"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0j8rlra9jg8f0i2vsa26fmda670x4h7fzchnbnwnw0niavcvqn79";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "2.1.0";
  };
  sprockets = {
    dependencies = ["concurrent-ruby" "rack"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "15rzfzd9dca4v0mr0bbhsbwhygl0k9l24iqqlx0fijig5zfi66wm";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "4.2.1";
  };
  sprockets-rails = {
    dependencies = ["actionpack" "activesupport" "sprockets"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "17hiqkdpcjyyhlm997mgdcr45v35j5802m5a979i5jgqx5n8xs59";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "3.5.2";
  };
  statsd-ruby = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "028136c463nbravckxb1qi5c5nnv9r6vh2cyhiry423lac4xz79n";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "1.5.0";
  };
  stringio = {
    groups = ["default" "development" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "07mfqb40b2wh53k33h91zva78f9zwcdnl85jiq74wnaw2wa6wiak";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "3.1.1";
  };
  thor = {
    groups = ["default" "development" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1nmymd86a0vb39pzj2cwv57avdrl6pl3lf5bsz58q594kqxjkw7f";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "1.3.2";
  };
  tilt = {
    groups = ["default" "development"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0kds7wkxmb038cwp6ravnwn8k65ixc68wpm8j5jx5bhx8ndg4x6z";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "2.4.0";
  };
  timeout = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "16mvvsmx90023wrhf8dxc1lpqh0m8alk65shb7xcya6a9gflw7vg";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.4.1";
  };
  tzinfo = {
    dependencies = ["concurrent-ruby"];
    groups = ["default" "development" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "16w2g84dzaf3z13gxyzlzbf748kylk5bdgg3n1ipvkvvqy685bwd";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "2.0.6";
  };
  uktt = {
    dependencies = ["faraday" "faraday-net_http_persistent" "faraday_middleware" "net-http-persistent"];
    groups = ["default"];
    platforms = [];
    source = {
      fetchSubmodules = false;
      rev = "7f52e975697f9bd680f265613474113c881e16e0";
      sha256 = "1v15gbgyxpnldkrzlmrm58y4p6vy6bldj7xf3w7k0kxlrimxjknw";
      type = "git";
      url = "https://github.com/trade-tariff/uktt.git";
    };
    targets = [];
    version = "2.6.0";
  };
  unicode-display_width = {
    groups = ["default" "development" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0nkz7fadlrdbkf37m0x7sw8bnz8r355q3vwcfb9f9md6pds9h9qj";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "2.6.0";
  };
  useragent = {
    groups = ["default" "development" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1fv5kvq494swy0p17h9qya9r50w15xsi9zmvhzb8gh55kq6ki50p";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.16.10";
  };
  web-console = {
    dependencies = ["actionview" "activemodel" "bindex" "railties"];
    groups = ["development"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "087y4byl2s3fg0nfhix4s0r25cv1wk7d2j8n5324waza21xg7g77";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "4.2.1";
  };
  webpacker = {
    dependencies = ["activesupport" "rack-proxy" "railties" "semantic_range"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0fh4vijqiq1h7w28llk67y9csc0m4wkdivrsl4fsxg279v6j5z3i";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "5.4.4";
  };
  webrick = {
    groups = ["default" "development" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "13qm7s0gr2pmfcl7dxrmq38asaza4w0i2n9my4yzs499j731wh8r";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "1.8.1";
  };
  websocket-driver = {
    dependencies = ["websocket-extensions"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1nyh873w4lvahcl8kzbjfca26656d5c6z3md4sbqg5y1gfz0157n";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.7.6";
  };
  websocket-extensions = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0hc2g9qps8lmhibl5baa91b4qx8wqw872rgwagml78ydj8qacsqw";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.1.5";
  };
  yard = {
    groups = ["default" "development"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "14k9lb9a60r9z2zcqg08by9iljrrgjxdkbd91gw17rkqkqwi1sd6";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.9.37";
  };
  zeitwerk = {
    groups = ["default" "development" "test"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "10cpfdswql21vildiin0q7drg5zfzf2sahnk9hv3nyzzjqwj2bdx";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "2.6.18";
  };
}