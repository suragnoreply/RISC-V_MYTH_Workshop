\m4_TLV_version 1d: tl-x.org
\SV

\TLV cal_viz(@_stage)
   |calc
      @_stage
         $ANY = /top|tb/default<>0$ANY;
         `BOGUS_USE($dummy)
   |tb
      @_stage
         /default
            $valid = '0;
            $op1[2:0] = '0;
            $val1[31:0] = '0;
            $val2[31:0] = '0;
            $out[31:0] = '0;
            $recall[31:0] = '0;
            //$is_invalid_op = '0;
            $dummy = 0;
            `BOGUS_USE($recall $valid $op1 $val1 $val2 $out $dummy)
         $ANY = /top|calc<>0$ANY;
         
         // Needed for viz
         $op_viz[2:0] = $op1;
         $issum = $valid && ($op_viz[2:0] == 3'b000);
         $ismin = $valid && ($op_viz[2:0] == 3'b001);
         $isprod = $valid && ($op_viz[2:0] == 3'b010);
         $isquot = $valid && ($op_viz[2:0] == 3'b011);
         $is_invalid_op = $valid && ($op_viz[2:0] == 3'b110 || $op_viz[2:0] == 3'b111);
         $ismem = $valid && ($op_viz[2:0] == 3'b101);
         $isrecall = ($valid && ($op_viz[2:0] == 3'b100));
         $val1t = $valid && !$isrecall && !$is_invalid_op;
         $val2t = $valid && !$isrecall && !$ismem && !$is_invalid_op;
         $outt  = $valid && ($out_modified || !(|$out_modified)) && !$is_invalid_op && !$ismem;
         $out_modified[31:0] = ($out > ((1 << 31) - 1)) ? (~$out + 1) : $out;
         $isnegnum = ($out > ((1 << 31) - 1));
         \viz_alpha
            initEach: function() {
            let calbox = new fabric.Rect({
              left: 150,
              top: 150,
              fill: "#eeeeeeff",
              width: 316,
              height: 366,
              stroke: "black",
              strokeWidth: 1,
            });
            let val1box = new fabric.Rect({
              left: 150 + 28,
              top: 150 + 83,
              fill: "#eeeeeeff",
              width: 254 + 14,
              height: 40,
              stroke: "black",
              strokeWidth: 1,
            });
            let val1num = new fabric.Text("", {
              left: 150 + 28 + 30,
              top: 150 + 89,
              fontSize: 22,
              fontFamily: "Times",
            });
            let val2box = new fabric.Rect({
              left: 150 + 187,
              top: 150 + 221,
              fill: "#eeeeeeff",
              width: 109,
              height: 40,
              stroke: "black",
              strokeWidth: 1,
            });
            let val2num = new fabric.Text("", {
              left: 150 + 187 + 1,
              top: 150 + 221 + 7,
              fontSize: 22,
              fontFamily: "Times",
            });
            let outbox = new fabric.Rect({
              left: 150 + 97,
              top: 150 + 300,
              fill: "#eeeeeeff",
              width: 199,
              height: 40,
              stroke: "black",
              strokeWidth: 1,
            });
            let outnum = new fabric.Text("", {
              left: 150 + 97 + 20,
              top: 150 + 300 + 8,
              fontSize: 22,
              fontFamily: "Times",
            });
            let outnegsign = new fabric.Text("-", {
              left: 150 + 97 + 8,
              top: 150 + 300 + 6,
              fontSize: 22,
              fontFamily: "Times",
              fill : "#eeeeeeff",
            });
            let equalname = new fabric.Text("=", {
              left: 150 + 38,
              top: 150 + 306,
              fontSize: 28,
              fontFamily: "Times",
            });
              let sumbox = new fabric.Rect({
              left: 150 + 28,
              top: 150 + 148,
              fill: "#eeeeeeff",
              //fill: colorsum,
              width: 64,
              height: 64,
              stroke: "black",
              strokeWidth: 1
            });
            let prodbox = new fabric.Rect({
              left: 150 + 28,
              top: 150 + 222,
              fill: "#eeeeeeff",
              //fill: colorprod,
              width: 64,
              height: 64,
              stroke: "black",
              strokeWidth: 1
            });
            let minbox = new fabric.Rect({
              left: 150 + 105,
              top: 150 + 148,
              fill: "#eeeeeeff",
              //fill: colormin,
              width: 64,
              height: 64,
              stroke: "black",
              strokeWidth: 1
            });
            let quotbox = new fabric.Rect({
              left: 150 + 105,
              top: 150 + 222,
              fill: "#eeeeeeff",
              //fill: colorquot,
              width: 64,
              height: 64,
              stroke: "black",
              strokeWidth: 1
            });
            let sumicon = new fabric.Text("+", {
              left: 150 + 28 + 26,
              top: 150 + 148 + 22,
              fontSize: 22,
              fontFamily: "Times",
            });
            let prodicon = new fabric.Text("*", {
              left: 150 + 28 + 26,
              top: 150 + 222 + 22,
              fontSize: 22,
              fontFamily: "Times",
            });
            let minicon = new fabric.Text("-", {
              left: 150 + 105 + 26,
              top: 150 + 148 + 22,
              fontSize: 22,
              fontFamily: "Times",
            });
            let quoticon = new fabric.Text("/", {
              left: 150 + 105 + 26,
              top: 150 + 222 + 22,
              fontSize: 22,
              fontFamily: "Times",
            });
              let membox = new fabric.Rect({
              left: 105 + 150,
              top: 150 + 25,
              fill: "#eeeeeeff",
              width: 191,
              height: 23,
              stroke: "black",
              strokeWidth: 1,
            });
            let memname = new fabric.Text("mem", {
              left: 150 + 28,
              top: 150 + 25,
              fontSize: 22,
              fontFamily: "Times",
            });
            let memarrow = new fabric.Text("->", {
              left: 150 + 32 + 47,
              top: 150 + 25,
              fill: "#eeeeeeff",
              fontSize: 22,
              fontFamily: "monospace",
            });
            let recallarrow = new fabric.Text("->", {
              left: 150 + 38 + 28,
              top: 150 + 308,
              fill: "#eeeeeeff",
              fontSize: 22,
              fontFamily: "monospace",
            });
            let memnum = new fabric.Text("", {
              left: 150 + 105 + 30,
              top: 150 + 25,
              fontSize: 22,
              fontFamily: "Times",
            });
            let membuttonbox = new fabric.Rect({
              left: 150 + 187,
              top: 150 + 151, //fixed
              fill: "#eeeeeeff",
              width: 45,
              height: 40,
              stroke: "black",
              strokeWidth: 1
            });
            let recallbuttonbox = new fabric.Rect({
              left: 150 + 245,
              top: 150 + 151, //fixed
              fill: "#eeeeeeff",
              width: 51,
              height: 40, //fixed
              stroke: "black",
              strokeWidth: 1
            });
            let membuttonname = new fabric.Text("mem", {
              left: 150 + 187 + 1,
              top: 150 + 151 + 7,
              fontSize: 22,
              fontFamily: "Times",
            });
            let recallbuttonname = new fabric.Text("recall", {
              left: 150 + 245 + 1,
              top: 150 + 151 + 7,
              fontSize: 22,
              fontFamily: "Times",
            });
            return {objects: {calbox: calbox, val1box: val1box, val1num: val1num, val2box: val2box, val2num: val2num, outbox: outbox, outnum: outnum, equalname: equalname, sumbox: sumbox, minbox: minbox, prodbox: prodbox, quotbox: quotbox, sumicon: sumicon, prodicon: prodicon, minicon: minicon, quoticon: quoticon, outnegsign: outnegsign,  membox: membox, memname: memname, memnum: memnum, membuttonbox: membuttonbox, recallbuttonbox: recallbuttonbox, membuttonname: membuttonname, recallbuttonname: recallbuttonname, memarrow: memarrow, recallarrow: recallarrow}};
            },
            renderEach: function() {
               let colorsum =  '$issum'.asBool(false);
               let colorprod = '$isprod'.asBool(false);
               let colormin = '$ismin'.asBool(false);
               let colorquot = '$isquot'.asBool(false);
               let colormembutton = '$ismem'.asBool(false);
               let colorrecallbutton = '$isrecall'.asBool(false);
               let colormemarrow = '$ismem'.asBool(false);
               let colorrecallarrow = '$isrecall'.asBool(false);
               let recallmod = '$isrecall'.asBool(false);
               let val1mod = '$val1t'.asBool(false);
               let val2mod = '$val2t'.asBool(false);
               let outmod = '$outt'.asBool(false);
               let colornegnum = '$isnegnum'.asBool(false);
               let oldvalval1 = "";
               let oldvalval2 = "";
               let oldvalout = "";
               let oldvalrecall = "";
               this.getInitObject("val1num").setText(
                  '$val1'.asInt(NaN).toString() + oldvalval1);
               this.getInitObject("val1num").setFill(val1mod ? "blue" : "grey");
               this.getInitObject("val2num").setText(
                  '$val2'.asInt(NaN).toString() + oldvalval2);
               this.getInitObject("val2num").setFill(val2mod ? "blue" : "grey");
               this.getInitObject("outnum").setText(
                  '$out_modified'.asInt(NaN).toString() + oldvalout);
               this.getInitObject("outnum").setFill(outmod ? "blue" : "grey");
               this.getInitObject("memnum").setText(
                  '$recall'.asInt(NaN).toString() + oldvalrecall);
               this.getInitObject("memnum").setFill((recallmod || colormembutton) ? "blue" : "grey");
               this.getInitObject("outnegsign").setFill(colornegnum ?  "blue" : "#eeeeeeff");
               this.getInitObject("sumbox").setFill(colorsum ?  "#9fc5e8ff" : "#eeeeeeff");
               this.getInitObject("minbox").setFill(colormin ?  "#9fc5e8ff" : "#eeeeeeff");
               this.getInitObject("prodbox").setFill(colorprod ? "#9fc5e8ff" : "#eeeeeeff");
               this.getInitObject("quotbox").setFill(colorquot ?  "#9fc5e8ff" : "#eeeeeeff");
               this.getInitObject("membuttonbox").setFill(colormembutton ? "#9fc5e8ff" : "#eeeeeeff");
               this.getInitObject("recallbuttonbox").setFill(colorrecallbutton ?  "#9fc5e8ff" : "#eeeeeeff");
               this.getInitObject("memarrow").setFill(colormemarrow ? "blue" : "#eeeeeeff");
               this.getInitObject("recallarrow").setFill(colorrecallarrow ?  "blue" : "#eeeeeeff");
             }
