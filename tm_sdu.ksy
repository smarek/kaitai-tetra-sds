meta:
  id: tm_sdu
seq:
  - id: llc_pdu_type_flag
    type: b4
instances:
  llc_pdu_type:
    value: llc_pdu_type_flag
    enum: llc_pdu_types_enum
enums:
  llc_pdu_types_enum:
    0: bl_adata
    1: bl_data
    2: bl_udata
    3: bl_ack
    4: bl_adata_fcs
    5: bl_data_fcs
    6: bl_udata_fcs
    7: bl_ack_fcs
    8: al_setup
    9: al_data
    10: al_udata
    11: al_ack
    12: al_reconnect
    15: al_disc
