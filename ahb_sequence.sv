class ahb_sequence extends uvm_sequence #(ahb_transaction);

  `uvm_object_utils(ahb_sequence)

  task body();

    ahb_transaction tr;

    repeat(500) begin

      tr = ahb_transaction::type_id::create("tr");

      assert(tr.randomize() with {
        addr inside {[0:255]};

        size dist {
          3'b000 := 30,
          3'b001 := 30,
          3'b010 := 40
        };

        burst dist {
          3'b000 := 50,
          3'b001 := 50
        };

        write_flag dist {1 := 50, 0 := 50};

        // alignment (important)
        addr % (1 << size) == 0;
      });

      start_item(tr);
      finish_item(tr);

    end
  endtask
endclass
