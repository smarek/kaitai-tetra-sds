meta:
  id: pdu_mac
  title: 21.4.1 MAC PDU TYPE
  ks-version: 0.8
  endian: be
  imports:
    - tm_sdu
params:
  - id: uplink
    type: bool
seq:
  - id: mac_pdu_type_header
    type: b2
  - id: mac_pdu
    type:
      switch-on: mac_pdu_type
      cases:
        mac_pdu_types_enum::tma_sap_mac_data_or_mac_resource: tma_sap_mac_pdu_switch(uplink)
        mac_pdu_types_enum::tma_sap_mac_end_or_mac_frag: tma_sap_mac_end
        mac_pdu_types_enum::tmb_sap_broadcast: tmb_sap_mac_broadcast
        mac_pdu_types_enum::tmd_sap_mac_u_signal: tmd_sap_mac_u_signal
instances:
  mac_pdu_type:
    value: mac_pdu_type_header
    enum: mac_pdu_types_enum
types:
  mac_length_indication:
    seq:
      - id: length_indication
        type: b6
  mac_capacity_request:
    seq:
      - id: fragmentation_flag
        type: b1
      - id: reservation_requirement
        type: b4
      - id: reserved_bit
        type: b1
  mac_address_with_type:
    seq:
      - id: mac_address_type
        type: b2
      - id: address
        type:
          switch-on: mac_address_type
          cases:
            0: b24
            1: b24
            2: b24
            3: b10
  mac_address_with_type_mac_resource:
    seq:
      - id: mac_address_type
        type: b3
      - id: address
        type:
          switch-on: mac_address_type
          cases:
            0: b1
            1: b24
            2: b10
            3: b24
            4: b24
            5: b34
            6: b30
            7: b34
  tma_sap_mac_pdu_switch:
    params:
      - id: uplink
        type: bool
    seq:
      - id: mac_pdu_data
        type: tma_sap_mac_pdu_data
        if: uplink == true
      - id: mac_pdu_resource
        type: tma_sap_mac_pdu_resource
        if: uplink == false
  tma_sap_mac_pdu_resource:
    seq:
      - id: fill_bit_indication
        type: b1
      - id: position_of_grant
        type: b1
      - id: encryption_mode
        type: b2
      - id: random_access_flag
        type: b1
      - id: length_indication
        type: b6
      - id: address_type
        type: mac_address_with_type
      - id: power_control_flag
        type: b1
      - id: power_control_element
        type: b4
        if: power_control_flag
      - id: slot_granting_flag
        type: b1
      - id: slot_granting_element
        type: b8
        if: slot_granting_flag
      - id: channel_allocation_flag
        type: b1
      - id: channel_allocation_element
        type: mac_channel_allocation_element
  mac_channel_allocation_element:
    seq:
      - id: channel_allocation_type
        type: b2
  tma_sap_mac_pdu_data:
    seq:
      - id: fill_bit_indication
        type: b1
      - id: encrypted_flag
        type: b1
      - id: address_type
        type: mac_address_with_type
      - id: mac_length_indication_or_capacity_request_flag
        type: b1
      - id: mac_length_indication_or_capacity_request
        type:
          switch-on: mac_length_indication_or_capacity_request_flag
          cases:
            false: mac_length_indication
            true: mac_capacity_request
      - id: mac_tm_sdu
        type: tm_sdu
  tma_sap_mac_end:
    seq:
      - id: pdu_subtype
        type: b1
      - id: fill_bit_indication
        type: b1
      - id: length_indication
        type: b6
  tmb_sap_mac_broadcast:
    seq:
      - id: broadcast_type
        type: b2
  tmd_sap_mac_u_signal:
    seq:
      - id: second_half_slot_stolen_flag
        type: b1
      - id: tm_sdu
        type: b121
enums:
  mac_pdu_types_enum:
    0: tma_sap_mac_data_or_mac_resource # mac-data uplink from MS, mac-resource downlink from BS
    1: tma_sap_mac_end_or_mac_frag # both uplink and downlink
    2: tmb_sap_broadcast # sync, sysinfo and access-define
    3: tmd_sap_mac_u_signal # both uplink and downlink
