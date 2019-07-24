# frozen_string_literal: true

RgGen.define_list_item_feature(:bit_field, :type, :ro) do
  register_map do
    read_only
    use_reference
  end

  sv_rtl do
    build do
      unless bit_field.reference?
        input :register_block, :value_in, {
          name: "i_#{full_name}",
          data_type: :logic,
          width: bit_field.width,
          array_size: bit_field.array_size,
          array_format: array_port_format
        }
      end
    end

    main_code :bit_field, from_template: true

    private

    def reference_or_value_in
      if bit_field.reference?
        reference_bit_field
      else
        value_in[bit_field.loop_variables]
      end
    end
  end
end
