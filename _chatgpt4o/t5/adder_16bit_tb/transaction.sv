// adder_transaction.sv
class adder_transaction extends uvm_sequence_item;
  `uvm_object_utils(adder_transaction)

  rand bit [15:0] a;
  rand bit [15:0] b;
  rand bit Cin;
  bit [15:0] y;
  bit Co;

  function new(string name = "adder_transaction");
    super.new(name);
  endfunction

  virtual function void do_print(uvm_printer printer);
    super.do_print(printer);
    printer.print_field_int("a", a, 16);
    printer.print_field_int("b", b, 16);
    printer.print_field_int("Cin", Cin, 1);
    printer.print_field_int("y", y, 16);
    printer.print_field_int("Co", Co, 1);
  endfunction
endclass
