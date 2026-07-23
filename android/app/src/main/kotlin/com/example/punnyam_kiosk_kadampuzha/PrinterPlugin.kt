package com.example.punnyam_kiosk_kadampuzha
import com.kioskworldline.com.UsbDriver
import com.kioskworldline.com.PrintCmd

import android.content.Context
import android.hardware.usb.UsbManager
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class PrinterPlugin(
    private val context: Context
) : MethodChannel.MethodCallHandler {

    private var usbDriver: UsbDriver? = null

    init {
        usbDriver = UsbDriver(
            context.getSystemService(
                Context.USB_SERVICE
            ) as UsbManager,
            context
        )
    }

    override fun onMethodCall(
        call: MethodCall,
        result: MethodChannel.Result
    ) {

        when (call.method) {

            "connect" -> {

                val connected =
                    usbDriver?.openUsbDevice() ?: false

                result.success(connected)
            }

            "printText" -> {

                val text =
                    call.argument<String>("text") ?: ""

                usbDriver?.write(
                    PrintCmd.SetClean()
                )

                usbDriver?.write(
                    PrintCmd.PrintString(
                        text,
                        0
                    )
                )

                usbDriver?.write(
                    PrintCmd.PrintFeedline(2)
                )

                result.success(true)
            }

            "cutPaper" -> {

                usbDriver?.write(
                    PrintCmd.PrintCutpaper(0)
                )

                result.success(true)
            }

            "printReceipt" -> {
val temple =  call.argument<String>("temple") ?: ""
val templeAddress =  call.argument<String>("templeAddress") ?: ""
val templePlace =  call.argument<String>("templePlace") ?: ""
                val billNo =
                    call.argument<String>("billNo") ?: ""

                val date =
                    call.argument<String>("date") ?: ""

                val mode =
                    call.argument<String>("mode") ?: ""

                val total =
                    call.argument<String>("total") ?: ""

                val website =
                    call.argument<String>("website") ?: ""
                val items =call.argument<List<Map<String, Any?>>>("items")
        ?: emptyList()

                printReceipt(
                    temple,
                    templeAddress,
                    templePlace,
                    billNo,
                    date,
                    mode,
                    total,
                    website,
                    items
                )

                result.success(true)
            }

            else -> result.notImplemented()
        }
    }

    private fun printTwoColumn(
        left: String,
        right: String
    ) {

        val width = 32

        val spaces =
            (width - left.length - right.length)
                .coerceAtLeast(1)

        val line =
            left + " ".repeat(spaces) + right

        usbDriver?.write(
            PrintCmd.PrintString(
                line,
                0
            )
        )
    }

    private fun printReceipt(
        temple: String,
    templeAddress: String,
    templePlace: String,
    billNo: String,
    date: String,
    mode: String,
    total: String,
    website: String,
    items: List<Map<String, Any?>>
) {

  usbDriver?.write(PrintCmd.SetClean())

usbDriver?.write(PrintCmd.PrintString(temple.uppercase(), 0))
usbDriver?.write(PrintCmd.PrintString(templeAddress, 0))
usbDriver?.write(PrintCmd.PrintString(templePlace, 0))

usbDriver?.write(PrintCmd.PrintFeedline(1))

usbDriver?.write(
    PrintCmd.PrintString(
        "--------------------------------",
        0
    )
)

    printTwoColumn(
        "Bill No: $billNo",
        date
    )

    usbDriver?.write(
        PrintCmd.PrintString(
            "--------------------------------",
            0
        )
    )

    for (item in items) {

        val personId =
            item["personId"]?.toString() ?: ""

        val personName =
            item["personName"]?.toString() ?: ""

        val deity =
            item["deity"]?.toString() ?: ""

        val star =
            item["star"]?.toString() ?: ""

        val pooja =
            item["pooja"]?.toString() ?: ""

        val qty =
            item["qty"]?.toString() ?: ""

        val rate =
            item["rate"]?.toString() ?: ""

        val poojaDate =
            item["date"]?.toString() ?: ""

        val address =
            item["address"]?.toString() ?: ""

        usbDriver?.write(
            PrintCmd.PrintString("$personId. $deity",
                0
            )
        )

        usbDriver?.write(
            PrintCmd.PrintString(
                "$personName - $star",
                0
            )
        )

        usbDriver?.write(
            PrintCmd.PrintString(
                "$pooja  $qty x $rate",
                0
            )
        )

        if (poojaDate.isNotEmpty()) {
            usbDriver?.write(
                PrintCmd.PrintString(
                    poojaDate,
                    0
                )
            )
        }

        if (address.isNotEmpty()) {
            usbDriver?.write(
                PrintCmd.PrintString(
                    address,
                    0
                )
            )
        }

        usbDriver?.write(
            PrintCmd.PrintFeedline(1)
        )
    }

    usbDriver?.write(
        PrintCmd.PrintString(
            "--------------------------------",
            0
        )
    )

    printTwoColumn(
        "Mode: $mode",
        "Total: Rs.$total"
    )

    usbDriver?.write(
        PrintCmd.PrintFeedline(1)
    )

    usbDriver?.write(
        PrintCmd.PrintString(
            "Book Online $website",
            0
        )
    )

    usbDriver?.write(
        PrintCmd.PrintFeedline(3)
    )

    usbDriver?.write(
        PrintCmd.PrintCutpaper(0)
    )
}

}