package com.example.savis_intern_project.service;

import com.example.savis_intern_project.entity.Bill;
import com.example.savis_intern_project.entity.BillDetail;
import com.example.savis_intern_project.entity.ViewModels.BillDetailView;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service
public interface BillDetailService {
    void create_new_billdetail(BillDetail billDetail);

    List<BillDetail> get_all_billdetail();

    List<BillDetail> get_all_by_billId(UUID billId);
    List<BillDetailView> getByBillId(UUID billId);

    BillDetail get_one_bill_detail(UUID billDetailId);

//    void change_bill_status(UUID billDetailId);

    void delete_detail(UUID billDetailId);
}
